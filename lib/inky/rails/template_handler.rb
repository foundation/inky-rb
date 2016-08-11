module Inky
  module Rails
    class TemplateHandler
      def self.engine_handler
        @@engine_handler ||= ActionView::Template.registered_template_handler(::Inky.configuration.template_engine)
      end

      def self.call(template)
        compiled_source = engine_handler.call(template)
        "Inky::Core.new.release_the_kraken(begin; #{compiled_source};end)"
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler :inky, Inky::Rails::TemplateHandler
end
