class Inky
  attr_accessor :components
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
  end


  def release_the_kraken(xml)
    transformed_xml = xml

    # do some stuff
    return transformed_xml
  end
end
