require 'spec_helper'

RSpec.describe "Center" do
  it "applies a text-center class and center alignment attribute to the first child" do
    input = '<center><div></div></center>'
    expected = <<-HTML
      <center>
        <div align="center" class="float-center"></div>
      </center>
    HTML

    compare(input, expected)
  end

  it "doesn't choke if center tags are nested" do
    input = '<center><center>a</center></center>'

    expected = <<-HTML
      <center>
        <center align="center" class="float-center">
        a
        </center>
      </center>
    HTML

    compare(input, expected)
  end

  it "applies the class float-center to <item> elements" do
    input = '<center><menu><item href="#"></item></menu></center>'

    expected = <<-HTML
      <center>
        <table class="float-center menu " align="center">
          <tr>
            <td>
              <table>
                <tr>
                  <th class="float-center menu-item">
                    <a href="#"></a>
                  </th>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </center>
    HTML

    compare(input, expected)
  end
end

RSpec.describe "Button" do
  it "creates a simple button" do
    input = '<button href="http://zurb.com">Button</button>'
    expected = <<-HTML
      <table class="button">
        <tr>
          <td>
            <table>
              <tr>
                <td><a href="http://zurb.com">Button</a></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    HTML
    compare(input, expected)
  end

  it 'creates a button with target="_blank" attribute' do
    input = '<button href="http://zurb.com" target="_blank">Button</button>'
    expected = <<-HTML
      <table class="button">
        <tr>
          <td>
            <table>
              <tr>
                <td><a href="http://zurb.com" target="_blank">Button</a></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    HTML
    compare(input, expected)
  end

  it 'creates a button with classes' do
    input = '<button class="small alert" href="http://zurb.com">Button</button>'
    expected = <<-HTML
      <table class="button small alert">
        <tr>
          <td>
            <table>
              <tr>
                <td><a href="http://zurb.com">Button</a></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end

  it 'creates a correct expanded button' do
    input = '<button class="expand" href="http://zurb.com">Button</button>'
    expected = <<-HTML
      <table class="button expand">
        <tr>
          <td>
            <table>
              <tr>
                <td>
                  <center><a href="http://zurb.com" align="center" class="float-center">Button</a></center>
                </td>
              </tr>
            </table>
          </td>
          <td class="expander"></td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end
end

RSpec.describe "Menu" do
  it 'creates a menu with item tags inside' do
    input = <<-INKY
      <menu>
        <item href="http://zurb.com">Item</item>
      </menu>
    INKY
    expected = <<-HTML
      <table class="menu">
        <tr>
          <td>
            <table>
              <tr>
                <th class="menu-item"><a href="http://zurb.com">Item</a></th>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end

  it 'creates a menu with items tags inside, containing target="_blank" attribute' do
    input = <<-INKY
      <menu>
        <item href="http://zurb.com" target="_blank">Item</item>
      </menu>
    INKY
    expected = <<-HTML
      <table class="menu">
        <tr>
          <td>
            <table>
              <tr>
                <th class="menu-item"><a href="http://zurb.com" target="_blank">Item</a></th>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end

  it 'creates a menu with classes' do
    input = <<-INKY
      <menu class="vertical">
      </menu>
    INKY
    expected = <<-HTML
      <table class="menu vertical">
        <tr>
          <td>
            <table>
              <tr>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end

  it 'works without using an item tag' do
    input = <<-INKY
      <menu>
        <th class="menu-item"><a href="http://zurb.com">Item 1</a></th>
      </menu>
    INKY
    expected = <<-HTML
      <table class="menu">
        <tr>
          <td>
            <table>
              <tr>
                <th class="menu-item"><a href="http://zurb.com">Item 1</a></th>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end
end

RSpec.describe "Callout" do
  it "creates a callout with correct syntax" do
    input = '<callout>Callout</callout>'
    expected = <<-HTML
      <table class="callout">
        <tr>
          <th class="callout-inner">Callout</th>
          <th class="expander"></th>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end

  it "copies classes to the final HTML" do
    input = '<callout class="primary">Callout</callout>'
    expected = <<-HTML
      <table class="callout">
        <tr>
          <th class="callout-inner primary">Callout</th>
          <th class="expander"></th>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end
end

RSpec.describe "Spacer" do
  it 'creates a spacer element with correct size' do
    input = '<spacer size="10"></spacer>'
    expected = <<-HTML
      <table class="spacer">
        <tbody>
          <tr>
            <td height="10px" style="font-size:10px;line-height:10px;">&#xA0;</td>
          </tr>
        </tbody>
      </table>
    HTML

    compare(input, expected)
  end

  it 'creates a spacer element for small screens with correct size' do
    input = '<spacer size-sm="10"></spacer>'
    expected = <<-HTML
      <table class="spacer hide-for-large">
        <tbody>
          <tr>
            <td height="10px" style="font-size:10px;line-height:10px;">&#xA0;</td>
          </tr>
        </tbody>
      </table>
    HTML

    compare(input, expected)
  end

  it 'creates a spacer element for large screens with correct size' do
    input = '<spacer size-lg="20"></spacer>'
    expected = <<-HTML
      <table class="spacer show-for-large">
        <tbody>
          <tr>
            <td height="20px" style="font-size:20px;line-height:20px;">&#xA0;</td>
          </tr>
        </tbody>
      </table>
    HTML

    compare(input, expected)
  end

  it 'creates a spacer element for small and large screens with correct sizes' do
    input = '<spacer size-sm="10" size-lg="20"></spacer>'
    expected = <<-HTML
        <table class="spacer hide-for-large">
          <tbody>
            <tr>
              <td height="10px" style="font-size:10px;line-height:10px;">&#xA0;</td>
            </tr>
          </tbody>
        </table>
        <table class="spacer show-for-large">
          <tbody>
            <tr>
              <td height="20px" style="font-size:20px;line-height:20px;">&#xA0;</td>
            </tr>
          </tbody>
        </table>
    HTML

    compare(input, expected)
  end

  it 'copies classes to the final spacer HTML' do
    input = '<spacer size="10" class="bgcolor"></spacer>'
    expected = <<-HTML
      <table class="spacer bgcolor">
        <tbody>
          <tr>
            <td height="10px" style="font-size:10px;line-height:10px;">&#xA0;</td>
          </tr>
        </tbody>
      </table>
    HTML

    compare(input, expected)
  end
end

RSpec.describe "Wrapper" do
  it 'creates a wrapper that you can attach classes to' do
    input = '<wrapper class="header"></wrapper>'
    expected = <<-HTML
      <table class="wrapper header" align="center">
        <tr>
          <td class="wrapper-inner"></td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end
end

RSpec.describe "raw" do
  it 'creates a wrapper that ignores anything inside' do
    input = "<body><raw><<LCG ProgramTG LCG Coupon Code Default='246996'>></raw></body>"
    expected = "<body><<LCG ProgramTG LCG Coupon Code Default='246996'>></body>"

    # Can't do vanilla compare because the second will fail to parse
    inky = ::Inky::Core.new
    output = inky.release_the_kraken(input)
    expect(output).to eql(expected)
  end
end
