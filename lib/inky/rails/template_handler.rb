module Inky
  module Rails
    class TemplateHandler
      class << self
        def engine_handler
          type = ::Inky.configuration.template_engine
          ActionView::Template.registered_template_handler(type) ||
            raise("No template handler found for #{type}")
        end

        def call(template)
          compiled_source = engine_handler.call(template)
          "Inky::Core.new.release_the_kraken(begin; #{compiled_source};end)"
        end
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler :inky, Inky::Rails::TemplateHandler
end
