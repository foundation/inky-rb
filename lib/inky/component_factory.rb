module Inky
  module ComponentFactory

    def component_factory(elem)
      component_instance = components[elem.name]
      return unless component_instance
      inner = elem.children.map(&:to_s).join
      component_instance.transform(elem, inner)
    end

  end
end
