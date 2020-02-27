require_relative "./base"

module Inky
  module Components
    class Row < Base

      def transform(component, inner)
        attributes = _combine_attributes(component, 'row')
        %{<table #{attributes}><tbody><tr>#{inner}</tr></tbody></table>}
      end
      
    end
  end
end