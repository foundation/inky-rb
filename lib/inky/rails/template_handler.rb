module Inky
  module Rails
    class TemplateHandler
      def initialize(compose_with = nil)
        @engine_handler = ActionView::Template.registered_template_handler(compose_with) if compose_with
      end

      def engine_handler
        return @engine_handler if @engine_handler

        type = ::Inky.configuration.template_engine
        ActionView::Template.registered_template_handler(type) ||
          raise("No template handler found for #{type}")
      end

      def call(template, source = nil)
        compiled_source =
          if source
            engine_handler.call(template, source)
          else
            engine_handler.call(template)
          end
        "Inky::Core.new.release_the_kraken(begin; #{compiled_source};end)"
      end

      module Composer
        def register_template_handler(ext, *)
          super
          super :"inky-#{ext}", Inky::Rails::TemplateHandler.new(ext)
        end
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.template_handler_extensions.each do |ext|
    ActionView::Template.register_template_handler :"inky-#{ext}", Inky::Rails::TemplateHandler.new(ext)
  end
  ActionView::Template.register_template_handler :inky, Inky::Rails::TemplateHandler.new
  ActionView::Template.singleton_class.send :prepend, Inky::Rails::TemplateHandler::Composer
end
