module ComponentFactory
  def component_factory(elem)
    inner = elem.children.map(&:to_s).join
    # TODO:  Handle changed names
    transform_method = :"_transform_#{self.component_lookup[elem.name]}"
    if self.respond_to?(transform_method)
      REXML::Document.new(self.send(transform_method, elem, inner))
    else
      nil
    end
  end

  def _has_class(elem, klass)
    !!elem.attributes['class'] && elem.attributes['class'].split(' ').include?(klass)
  end


  def _transform_button(component, inner)
    if component.attributes['href']
      inner = "<a href=\"#{component.attributes['href']}\">#{inner}</a>"
    end
    if _has_class(component, 'expand')
      inner = "<center>#{inner}</center>"
    end
    classes = ['button']
    if component.attributes['class']
      classes = classes.concat(component.attributes['class'].split(' '))
    end
    return "<table class=\"#{classes.join(' ')}\"><tr><td><table><tr><td>#{inner}</td></tr></table></td></tr></table>"
  end

  def _transform_menu(component, inner)
    "<table class=\"menu\"><tr>#{inner}</tr></table>"
  end

  def _transform_menu_item(component, inner)
    "<td><a href=\"#{component.attributes['href']}\">#{inner}</a></td>"
  end
end
