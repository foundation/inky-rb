require_relative "./base"

module Inky
  module Components
    class BlockGrid < Base

      def transform(component, inner)
        classes = _combine_classes(component, "block-grid up-#{component.attr('up')}")
        %{<table class="#{classes}"><tr>#{inner}</tr></table>}
      end
      
    end
  end
end