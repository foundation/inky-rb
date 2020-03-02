require_relative "./base"

module Inky
  module Components
    class MenuItem < Base

      def transform(component, inner)
        target = _target_attribute(component)
        attributes = _combine_attributes(component, 'menu-item')
        %{<#{::Inky::Core::INTERIM_TH_TAG} #{attributes}><a href="#{component.attr('href')}"#{target}>#{inner}</a></#{::Inky::Core::INTERIM_TH_TAG}>}
      end
      
    end
  end
end