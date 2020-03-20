require 'nokogiri'
require_relative 'inky/configuration'
require_relative 'inky/component_factory'

Dir.glob(File.expand_path("../inky/components/*", __FILE__)).each do |file|
  require_relative file
end

module Inky
  class Core
    attr_accessor :components, :column_count, :component_tags
    
    # These constants are used to circumvent an issue with JRuby Nokogiri.
    # For more details see https://github.com/zurb/inky-rb/pull/94
    INTERIM_TH_TAG = 'inky-interim-th'.freeze
    INTERIM_TH_TAG_REGEX = %r{(?<=\<|\<\/)#{Regexp.escape(INTERIM_TH_TAG)}}

    DEFAULT_COMPONENTS = {
      "button" => Inky::Components::Button,
      "row" => Inky::Components::Row,
      "inky" => Inky::Components::Inky,
      "columns" => Inky::Components::Columns,
      "container" => Inky::Components::Container,
      "block-grid" => Inky::Components::BlockGrid,
      "menu" => Inky::Components::Menu,
      "center" => Inky::Components::Center,
      "callout" => Inky::Components::Callout,
      "spacer" => Inky::Components::Spacer,
      "wrapper" => Inky::Components::Wrapper,
      "item" => Inky::Components::MenuItem
    }

    include ComponentFactory

    def initialize(options = {})
      self.components = DEFAULT_COMPONENTS
        .merge(options[:components] || ::Inky.configuration.components)
        .transform_values { |component_class| component_class.new(self) }
        .with_indifferent_access

      self.column_count = options[:column_count] || ::Inky.configuration.column_count
      self.component_tags = components.keys
    end

    def release_the_kraken(html_string)
      if html_string.encoding.name == "ASCII-8BIT"
        html_string.force_encoding('utf-8') # transform_doc barfs if encoding is ASCII-8bit
      end
      html_string = html_string.gsub(/doctype/i, 'DOCTYPE')
      raws, str = ::Inky::Core.extract_raws(html_string)
      parse_cmd = str =~ /<html/i ? :parse : :fragment
      html = Nokogiri::HTML.public_send(parse_cmd, str)
      transform_doc(html)
      string = html.to_html
      string.gsub!(INTERIM_TH_TAG_REGEX, 'th')
      ::Inky::Core.re_inject_raws(string, raws)
    end

    def transform_doc(elem)
      if elem.respond_to?(:children)
        elem.children.each do |child|
          transform_doc(child)
        end
        component = component_factory(elem)
        elem.replace(component) if component
      end
      elem
    end

    def self.extract_raws(string)
      raws = []
      i = 0
      regex = %r(< *raw *>(.*?)</ *raw *>)
      str = string
      while raw = str.match(regex)
        raws[i] = raw[1]
        str = str.sub(regex, "###RAW#{i}###")
        i += 1
      end
      [raws, str]
    end

    def self.re_inject_raws(string, raws)
      str = string
      raws.each_with_index do |val, i|
        str = str.sub("###RAW#{i}###", val)
      end
      # If we're in rails, these should be considered safe strings
      str = str.html_safe if str.respond_to?(:html_safe)
      str
    end
  end
end
begin
  # Only valid in rails environments
  require 'foundation_emails'
  require 'inky/rails/engine'
  require 'inky/rails/template_handler'
  require 'inky/rails/version'
rescue LoadError
end
