require_relative "./base"

module Inky
  module Components
    class Wrapper < Base

      def transform(component, inner)
        attributes = _combine_attributes(component, 'wrapper')
        %{<table #{attributes} align="center"><tr><td class="wrapper-inner">#{inner}</td></tr></table>}
      end
      
    end
  end
end