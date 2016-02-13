require 'inky'

require 'rexml/document'
def compare(input, expected)
  inky = Inky.new
  output = inky.release_the_kraken(input)

  #TODO:  Figure out how to do html compare in ruby
  output_str = REXML::Document.new(output).to_s.gsub(/\s/, '')
  expected_str = REXML::Document.new(expected).to_s.gsub(/\s/, '')
  expect(output_str).to eql(expected_str)
end
