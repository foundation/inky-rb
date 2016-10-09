require 'inky'

def reformat_html(html)
  html
    .gsub(/\s+/, ' ')                           # Compact all whitespace to a single space
    .gsub(/> *</, ">\n<")                       # Use returns between tags
    .gsub(%r{<(\w+)([^>]*)>\n</\1>}, '<\1\2/>') # Auto close empty tags, e.g. <hr>\n</hr> => <hr/>
    .gsub(/ "/, '"').gsub(/\=" /, '="')         # Remove leading/trailing spaces inside attributes
    .gsub(/ </, '<').gsub(/> /, '>')            # Remove leading/trailing spaces inside tags
    .gsub(' data-parsed=""', '')                # Don't consider this known inky-node artefact
    .gsub(/class\="([^"]+)"/) do                # Sort class names
      classes = $1.split(' ').sort.join(' ')
      %{class="#{classes}"}
    end
end

def compare(input, expected)
  inky = Inky::Core.new
  output = inky.release_the_kraken(input)

  # TODO:  Figure out a better way to do html compare in ruby..
  # this is overly dependent on things like class ordering, making it
  # fragile
  expect(reformat_html(output)).to eql(reformat_html(expected))
end
