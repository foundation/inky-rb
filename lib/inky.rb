module Inky
  class Core
    require 'nokogiri'
    require 'component_factory'
    attr_accessor :components, :column_count, :component_lookup, :component_tags

    include ComponentFactory
    def initialize(options = {})
      self.components = {
        button: 'button',
        row: 'row',
        columns: 'columns',
        container: 'container',
        inky: 'inky',
        block_grid: 'block-grid',
        menu: 'menu',
        center: 'center',
        callout: 'callout',
        spacer: 'spacer',
        wrapper: 'wrapper',
        menu_item: 'item'
      }.merge(options[:components] || {})

      self.component_lookup = self.components.invert

      self.column_count = options[:column_count] || 12

      self.component_tags = self.components.values
    end


    def release_the_kraken(xml_string)
      xml_string = xml_string.gsub(/doctype/i, 'DOCTYPE')
      raws, str = Inky::Core.extract_raws(xml_string)
      xml_doc = Nokogiri::XML(str)
      if self.components_exist?(xml_doc)
        self.transform_doc(xml_doc.root)
      end
      str = xml_doc.to_s
      return Inky::Core.re_inject_raws(str, raws)
    end


    def components_exist?(xml_doc)
      true
    end

    def transform_doc(elem)
      if elem.respond_to?(:children)
        elem.children.each do |child|
          transform_doc(child)
        end
        component = self.component_factory(elem)
        elem.replace(component) if component
      end
      elem
    end

    def self.extract_raws(string)
      raws = []
      i = 0
      regex = /\< *raw *\>(.*?)\<\/ *raw *\>/i;
      str = string
      while raw = str.match(regex)
        raws[i] = raw[1]
        str = str.sub(regex, "###RAW#{i}###")
        i = i + 1
      end
      return [raws, str]
     end

    def self.re_inject_raws(string, raws)
      str = string
      raws.each_with_index do |val, i|
        str = str.sub("###RAW#{i}###", val)
      end
      # If we're in rails, these should be considered safe strings
      if str.respond_to?(:html_safe)
        return str.html_safe
      else
        return str
      end
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
