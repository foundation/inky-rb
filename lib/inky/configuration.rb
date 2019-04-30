module Inky
  # @return [Inky::Configuration] Inky's current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Set Inky's configuration
  # @param config [Inky::Configuration]
  def self.configuration=(config)
    @configuration = config if config.is_a?(Configuration)
  end

  # Modify Inky's current configuration
  # @yieldparam [Inky::Configuration] config current Inky config
  # ```
  # Inky.configure do |config|
  #   config.template_engine = :slim
  #   config.column_count = 24
  # end
  # ```
  def self.configure
    yield configuration
  end

  class Configuration
    attr_reader :template_engine, :column_count, :components

    def initialize
      @template_engine = :erb
      @column_count = 12
      @components = {}
    end

    def template_engine=(value)
      @template_engine = value.to_sym
    end

    def components=(value)
      @components = value if value.is_a?(Hash)
    end

    def column_count=(value)
      @column_count = value if value.is_a?(Integer)
    end
  end
end
