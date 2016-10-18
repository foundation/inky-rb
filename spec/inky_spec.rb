require 'spec_helper'

RSpec.describe "Inky#release_the_kraken" do
  it "works on binary text" do
    input = '<container/>'.b
    expected = <<-HTML
      <table class="container" align="center">
        <tbody>
          <tr>
            <td></td>
          </tr>
        </tbody>
      </table>
    HTML

    output = Inky::Core.new.release_the_kraken(input)
    expect_same_html(output, expected)
  end
end
