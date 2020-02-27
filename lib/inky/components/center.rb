require_relative "./base"

module Inky
  module Components
    class Center < Base

      def transform(component, _inner)
        # NOTE:  Using children instead of elements because elements.to_a
        # sometimes appears to miss elements that show up in size
        component.elements.each do |child|
          child['align'] = 'center'
          child['class'] = _combine_classes(child, 'float-center')
          items = component.elements.css(".menu-item").to_a.concat(component.elements.css("item").to_a)
          items.each do |item|
            item['class'] = _combine_classes(item, 'float-center')
          end
        end
        component.to_s
      end
      
    end
  end
end