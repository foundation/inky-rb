require_relative "./base"

module Inky
  module Components
    class Button < Base

      def transform(component, inner)
        expand = _has_class(component, 'expand')
        if component.attr('href')
          target = _target_attribute(component)
          extra = ' align="center" class="float-center"' if expand
          inner = %{<a href="#{component.attr('href')}"#{target}#{extra}>#{inner}</a>}
        end
        inner = "<center>#{inner}</center>" if expand

        classes = _combine_classes(component, 'button')
        expander = '<td class="expander"></td>' if expand
        %{<table class="#{classes}"><tr><td><table><tr><td>#{inner}</td></tr></table></td>#{expander}</tr></table>}
      end
      
    end
  end
end