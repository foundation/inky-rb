require 'inky'

require 'rexml/document'
def compare(input, expected)
  inky = Inky::Core.new
  output = inky.release_the_kraken(input)

  # TODO:  Figure out a better way to do html compare in ruby..
  # this is overly dependent on things like class ordering, making it
  # fragile
  output_str = Nokogiri::XML(output).to_s.gsub(/\s/, '')
  expected_str = Nokogiri::XML(expected).to_s.gsub(/\s/, '')
  expect(output_str).to eql(expected_str)
end
