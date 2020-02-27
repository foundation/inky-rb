require_relative "./base"

module Inky
  module Components
    class Callout < Base

      def transform(component, inner)
        classes = _combine_classes(component, 'callout-inner')
        attributes = _pass_through_attributes(component)
        %{<table #{attributes}class="callout"><tr><th class="#{classes}">#{inner}</th><th class="expander"></th></tr></table>}
      end
      
    end
  end
end