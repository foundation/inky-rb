require 'rails/engine'

module Inky
  module Rails
    class Engine < ::Rails::Engine
      if config.respond_to?(:annotations)
        config.annotations.register_extensions("inky") { |annotation| /<!--\s*(#{annotation}):?\s*(.*) -->/ }
      end
    end
  end
end
