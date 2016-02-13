class Inky
  require 'rexml/document'
  require 'component_factory'
  attr_accessor :components, :column_count, :component_tags

  include ComponentFactory
  def initialize(options = {})
    self.components = {
      button: 'button',
      row: 'row',
      columns: 'columns',
      container: 'container',
      inky: 'inky',
      blockGrid: 'block-grid',
      menu: 'menu',
      menuItem: 'item'
    }.merge(options[:components] || {})

    self.column_count = options[:column_count] || 12

    self.component_tags = self.components.values
  end


  def release_the_kraken(xml_string)
    xml_doc = REXML::Document.new(xml_string)
    if self.components_exist?(xml_doc)
      self.transform_doc(xml_doc.root)
    end
    return xml_doc.to_s
  end


  def components_exist?(xml_doc)
    true
  end

  def transform_doc(elem)
    if elem.respond_to?(:children)
      elem.children.each do |child|
        transform_doc(child)
      end
      component = self.component_factory(elem)
      elem.replace_with(component)
    end
    elem
  end
end
