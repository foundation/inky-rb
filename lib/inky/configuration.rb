module Inky
  # @return [Inky::Configuration] Inky's current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Set Inky's configuration
  # @param config [Inky::Configuration]
  def self.configuration=(config)
    @configuration = config
  end

  # Modify Inky's current configuration
  # @yieldparam [Inky::Configuration] config current Inky config
  # ```
  # Inky.configure do |config|
  #   config.template_engine = :slim
  #   config.column_count = 24
  #   config.components = {
  #     'custom-block': My::Components::CustomBlock  
  #   }
  # end
  # ```
  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :template_engine, :column_count, :components

    def initialize
      @template_engine = :erb
      @column_count = 12
      @components = {}
    end
  end
end
