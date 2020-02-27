module Inky
  module Components
    class Base
      tags = %w[class id href size large no-expander small target]
      tags = tags.to_set if tags.respond_to? :to_set

      IGNORED_ON_PASSTHROUGH = tags.freeze

      attr_accessor :inky

      def initialize(inky)
        @inky = inky
      end

      def _pass_through_attributes(elem)
        elem.attributes.reject { |e| IGNORED_ON_PASSTHROUGH.include?(e.downcase) }.map do |name, value|
          %{#{name}="#{value}" }
        end.join
      end

      def _has_class(elem, klass)
        elem.attr('class') =~ /(^|\s)#{klass}($|\s)/
      end

      def _combine_classes(elem, extra_classes)
        existing = elem['class'].to_s.split(' ')
        to_add = extra_classes.to_s.split(' ')

        (existing + to_add).uniq.join(' ')
      end

      def _combine_attributes(elem, extra_classes = nil)
        classes = _combine_classes(elem, extra_classes)
        [_pass_through_attributes(elem), classes && %{class="#{classes}"}].join
      end

      def _target_attribute(elem)
        elem.attributes['target'] ? %{ target="#{elem.attributes['target']}"} : ''
      end
    end
  end
end
