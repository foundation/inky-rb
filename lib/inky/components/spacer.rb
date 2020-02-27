require_relative "./base"

module Inky
  module Components
    class Spacer < Base

      def transform(component, _inner)
        classes = _combine_classes(component, 'spacer')
        build_table = ->(size, extra) { %{<table class="#{classes} #{extra}"><tbody><tr><td height="#{size}px" style="font-size:#{size}px;line-height:#{size}px;">&#xA0;</td></tr></tbody></table>} }
        size = component.attr('size')
        size_sm = component.attr('size-sm')
        size_lg = component.attr('size-lg')
        if size_sm || size_lg
          html = ''
          html << build_table[size_sm, 'hide-for-large'] if size_sm
          html << build_table[size_lg, 'show-for-large'] if size_lg
          html
        else
          build_table[size || 16, nil]
        end
      end
      
    end
  end
end