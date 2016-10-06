module ComponentFactory
  def component_factory(elem)
    inner = elem.children.map(&:to_s).join
    # TODO:  Handle changed names
    transform_method = :"_transform_#{component_lookup[elem.name]}"
    return unless respond_to?(transform_method)
    Nokogiri::XML(send(transform_method, elem, inner)).root
  end

  tags = %w[class id href size large no-expander small target]
  tags = tags.to_set if tags.respond_to? :to_set
  IGNORED_ON_PASSTHROUGH = tags.freeze

  def _pass_through_attributes(elem)
    elem.attributes.reject { |e| IGNORED_ON_PASSTHROUGH.include?(e.downcase) }.map do |name, value|
      %{#{name}="#{value}" }
    end.join
  end

  def _has_class(elem, klass)
    (elem.attr('class') || '').include?(klass)
  end

  def _class_array(elem, defaults = [])
    classes = elem['class']
    defaults.concat(classes.split(' ')) if classes
    defaults
  end

  def _target_attribute(elem)
    elem.attributes['target'] ? %{ target="#{elem.attributes['target']}"} : ''
  end

  def _transform_button(component, inner)
    expand = _has_class(component, 'expand')
    if component.attr('href')
      target = _target_attribute(component)
      extra = ' align="center" class="float-center"' if expand
      inner = %{<a href="#{component.attr('href')}"#{target}#{extra}>#{inner}</a>}
    end
    inner = "<center>#{inner}</center>" if expand

    classes = _class_array(component, ['button'])
    expander = '<td class="expander"></td>' if expand
    %{<table class="#{classes.join(' ')}"><tr><td><table><tr><td>#{inner}</td></tr></table></td>#{expander}</tr></table>}
  end

  def _transform_menu(component, inner)
    classes = _class_array(component, ['menu'])
    %{<table class="#{classes.join(' ')}"><tr><td><table><tr>#{inner}</tr></table></td></tr></table>}
  end

  def _transform_menu_item(component, inner)
    target = _target_attribute(component)
    %{<th class="menu-item"><a href="#{component.attr('href')}"#{target}>#{inner}</a></th>}
  end

  def _transform_container(component, inner)
    classes = _class_array(component, ['container'])
    %{<table class="#{classes.join(' ')}"><tbody><tr><td>#{inner}</td></tr></tbody></table>}
  end

  def _transform_row(component, inner)
    classes = _class_array(component, ['row'])
    attrs = _pass_through_attributes(component)
    %{<table #{attrs}class="#{classes.join(' ')}"><tbody><tr>#{inner}</tr></tbody></table>}
  end

  # in inky.js this is factored out into makeClumn.  TBD if we need that here.
  def _transform_columns(component, inner)
    col_count = component.parent.elements.size

    small_val = component.attr('small')
    large_val = component.attr('large')

    small_size = small_val || column_count
    large_size = large_val || small_val || (column_count / col_count).to_i

    classes = _class_array(component, ["small-#{small_size}", "large-#{large_size}", "columns"])

    classes.push('first') unless component.previous_element
    classes.push('last') unless component.next_element

    subrows = component.elements.css(".row").to_a.concat(component.elements.css("row").to_a)
    expander = %{<th class="expander"></th>} if large_size.to_i == column_count && subrows.empty?

    %{<th class="#{classes.join(' ')}" #{_pass_through_attributes(component)}><table><tr><th>#{inner}</th>#{expander}</tr></table></th>}
  end

  def _transform_block_grid(component, inner)
    classes = _class_array(component, ['block-grid', "up-#{component.attr('up')}"])
    %{<table class="#{classes.join(' ')}"><tr>#{inner}</tr></table>}
  end

  def _transform_center(component, _inner)
    # NOTE:  Using children instead of elements because elements.to_a
    # sometimes appears to miss elements that show up in size
    component.elements.to_a.each do |child|
      child['align'] = 'center'
      child_classes = _class_array(child, ['float-center'])
      child['class'] = child_classes.join(' ')
      items = component.elements.css(".menu-item").to_a.concat(component.elements.css("item").to_a)
      items.each do |item|
        item_classes = _class_array(item, ['float-center'])
        item['class'] = item_classes.join(' ')
      end
    end
    component.to_s
  end

  def _transform_callout(component, inner)
    classes = _class_array(component, ['callout-inner'])
    %{<table class="callout"><tr><th class="#{classes.join(' ')}">#{inner}</th><th class="expander"></th></tr></table>}
  end

  def _transform_spacer(component, _inner)
    classes = _class_array(component, ['spacer'])
    build_table = ->(size, extra) { %{<table class="#{classes.join(' ')} #{extra}"><tbody><tr><td height="#{size}px" style="font-size:#{size}px;line-height:#{size}px;">&#xA0;</td></tr></tbody></table>} }
    size = component.attr('size')
    size_sm = component.attr('size-sm')
    size_lg = component.attr('size-lg')
    if size_sm || size_lg
      html = ''
      html << build_table[size_sm, 'hide-for-large'] if size_sm
      html << build_table[size_lg, 'show-for-large'] if size_lg
      html = "<span>#{html}</span>" if size_sm && size_lg
      html
    else
      build_table[size || 16, nil]
    end
  end

  def _transform_wrapper(component, inner)
    classes = _class_array(component, ['wrapper'])
    %{<table class="#{classes.join(' ')}" align="center"><tr><td class="wrapper-inner">#{inner}</td></tr></table>}
  end
end
