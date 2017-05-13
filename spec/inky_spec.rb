# encoding: utf-8

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

  it "works on utf-8 text" do
    input = '<container><p>Güten tag Marc-André</p></container>'
    expected = <<-HTML
      <table class="container" align="center">
        <tbody>
          <tr>
            <td><p>Güten tag Marc-André</p></td>
          </tr>
        </tbody>
      </table>
    HTML

    output = Inky::Core.new.release_the_kraken(input)
    expect_same_html(output, expected)
  end

  it "works on US-ASCII text" do
    input = '<container><p>G&#252;ten tag Marc-Andr&#233;</p></container>'.force_encoding("us-ascii")
    expected = <<-HTML
      <table class="container" align="center">
        <tbody>
          <tr>
            <td><p>G&#252;ten tag Marc-Andr&#233;</p></td>
          </tr>
        </tbody>
      </table>
    HTML

    output = Inky::Core.new.release_the_kraken(input)
    expect_same_html(output, expected)
    output.encoding.name.should == 'US-ASCII'
  end
end
