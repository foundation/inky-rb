module ComponentFactory
  def component_factory(elem)
    inner = elem.children.map(&:to_s).join
    # TODO:  Handle changed names
    transform_method = :"_transform_#{self.component_lookup[elem.name]}"
    if self.respond_to?(transform_method)
      REXML::Document.new(self.send(transform_method, elem, inner)).root
    else
      nil
    end
  end

  def _has_class(elem, klass)
    !!elem.attributes['class'] && elem.attributes['class'].split(' ').include?(klass)
  end

  def _class_array(elem, defaults = [])
    (elem.attributes['class'] ? (defaults.concat(elem.attributes['class'].split(' '))) : defaults).uniq
  end

  def _transform_button(component, inner)
    expand = _has_class(component, 'expand')
    if component.attributes['href']
      if expand
        inner = "<a href=\"#{component.attributes['href']}\" align=\"center\" class=\"text-center\">#{inner}</a>"
      else
        inner = "<a href=\"#{component.attributes['href']}\">#{inner}</a>"
      end
    end
    inner = "<center>#{inner}</center>" if expand

    classes = _class_array(component, ['button'])
    if expand
      return "<table class=\"#{classes.join(' ')}\"><tr><td><table><tr><td>#{inner}</td></tr></table></td><td class=\"expander\"></td></tr></table>"
    else
      return "<table class=\"#{classes.join(' ')}\"><tr><td><table><tr><td>#{inner}</td></tr></table></td></tr></table>"
    end
  end

  def _transform_menu(component, inner)
    classes = _class_array(component, ['menu'])
    "<table class=\"#{classes.join(' ')}\"><tr><td><table><tr>#{inner}</tr></table></td></tr></table>"
  end

  def _transform_menu_item(component, inner)
    "<th class=\"menu-item\"><a href=\"#{component.attributes['href']}\">#{inner}</a></th>"
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

    col_count = component.parent.elements.size
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

  def _transform_center(component, inner)
    # NOTE:  Using children instead of elements because elements.to_a
    # sometimes appears to miss elements that show up in size
    component.elements.to_a.each do |child|
      child.add_attribute('align', 'center')
      child_classes = _class_array(child, ['float-center'])
      child.add_attribute('class', child_classes.join(' '))
      items = component.elements.to_a("//*[contains(@class,'menu-item')]").concat(component.elements.to_a("//item"))
      items.each do |item|
        item_classes = _class_array(item, ['float-center'])
        item.add_attribute('class', item_classes.join(' '))
      end
    end
    return component.to_s
  end
end
