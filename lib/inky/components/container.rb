require_relative "./base"

module Inky
  module Components
    class Container < Base

      def transform(component, inner)
        attributes = _combine_attributes(component, 'container')
        %{<table #{attributes} align="center"><tbody><tr><td>#{inner}</td></tr></tbody></table>}
      end
      
    end
  end
end