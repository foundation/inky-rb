require 'spec_helper'

RSpec.describe "Center" do
  it "applies a float-center class and center alignment attribute to the first child" do
    input = '<center><div></div></center>';
    expected = <<-HTML
      <center>
        <div align="center" class="float-center"></div>
      </center>
    HTML

    compare(input, expected);
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

    compare(input, expected);
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

    compare(input, expected);
  end
end

RSpec.describe "Button" do
  it "creates a simple button" do
    input = '<button href="http://zurb.com">Button</button>';
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
    compare(input, expected);
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
                  <center><a href="http://zurb.com" align="center" class="text-center">Button</a></center>
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
