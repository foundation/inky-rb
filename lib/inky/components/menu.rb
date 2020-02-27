require_relative "./base"

module Inky
  module Components
    class Menu < Base

      def transform(component, inner)
        attributes = _combine_attributes(component, 'menu')
        %{<table #{attributes}><tr><td><table><tr>#{inner}</tr></table></td></tr></table>}
      end
      
    end
  end
end