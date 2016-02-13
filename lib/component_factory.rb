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

  def _class_array(elem, defaults = [])
    elem.attributes['class'] ? (defaults.concat(elem.attributes['class'].split(' '))) : defaults
  end

  def _transform_button(component, inner)
    if component.attributes['href']
      inner = "<a href=\"#{component.attributes['href']}\">#{inner}</a>"
    end
    if _has_class(component, 'expand')
      inner = "<center>#{inner}</center>"
    end
    classes = _class_array(component, ['button'])
    return "<table class=\"#{classes.join(' ')}\"><tr><td><table><tr><td>#{inner}</td></tr></table></td></tr></table>"
  end

  def _transform_menu(component, inner)
    "<table class=\"menu\"><tr>#{inner}</tr></table>"
  end

  def _transform_menu_item(component, inner)
    "<td><a href=\"#{component.attributes['href']}\">#{inner}</a></td>"
  end

  def _transform_container(component, inner)
    classes = _class_array(component, ['container'])
    "<table class=\"#{classes.join(' ')}\"><tbody><tr><td>#{inner}</td></tr></tbody></table>"
  end

  def _transform_row(component, inner)
    classes = _class_array(component, ['row'])
    "<table class=\"#{classes.join(' ')}\"><tbody><tr>#{inner}</tr></tbody></table>"
  end

  # in inky.js this is factored out into makeClumn.  TBD if we need that here.
  def _transform_columns(component, inner)

    col_count = component.parent.children.size
    small_size = component.attributes['small'] || self.column_count
    large_size = component.attributes['large'] || component.attributes['small'] || (self.column_count / col_count).to_i

    classes = _class_array(component, ["small-#{small_size}", "large-#{large_size}", "columns"])


    classes.push('first') unless component.previous_element
    classes.push('last') unless component.next_element

    subrows = component.elements.to_a("//*[contains(@class,'row')]").concat(component.elements.to_a("//row"))
    th_class = subrows.size == 0 ? ' class="expander"' : ''
    "<th class=\"#{classes.join(' ')}\"><table><tr><th#{th_class}>#{inner}</th></tr></table></th>"
  end

  def _transform_block_grid(component, inner)
    "<table class=\"block-grid up-#{component.attributes['up']}\"><tr>#{inner}</tr></table>"
  end
end
