require 'inky'

def compare(input, expected)
  inky = Inky.new
  output = inky.release_the_kraken(input)

  #TODO:  Figure out how to do html compare in ruby
  expect(output).to eql(expected)
end
