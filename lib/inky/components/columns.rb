require_relative "./base"

module Inky
  module Components
    class Columns < Base

      # in inky.js this is factored out into makeClumn.  TBD if we need that here.
      def transform(component, inner)
        col_count = component.parent.elements.size

        small_val = component.attr('small')
        large_val = component.attr('large')

        small_size = small_val || inky.column_count
        large_size = large_val || small_val || (inky.column_count / col_count).to_i

        classes = _combine_classes(component, "small-#{small_size} large-#{large_size} columns")

        classes << ' first' unless component.previous_element
        classes << ' last' unless component.next_element

        subrows = component.elements.css(".row").to_a.concat(component.elements.css("row").to_a)
        expander = %{<th class="expander"></th>} if large_size.to_i == inky.column_count && subrows.empty?

        %{<#{Inky::Core::INTERIM_TH_TAG} class="#{classes}" #{_pass_through_attributes(component)}><table><tr><th>#{inner}</th>#{expander}</tr></table></#{Inky::Core::INTERIM_TH_TAG}>}
      end
      
    end
  end
end