require 'spec_helper'

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
                  <center><a href="http://zurb.com">Button</a></center>
                </td>
              </tr>
            </table>
          </td>
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
          <td><a href="http://zurb.com">Item</a></td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end

  it 'works without using an item tag' do
    input = <<-INKY
      <menu>
        <td><a href="http://zurb.com">Item 1</a></td>
        <td><a href="http://zurb.com">Item 2</a></td>
      </menu>
    INKY
    expected = <<-HTML
      <table class="menu">
        <tr>
          <td><a href="http://zurb.com">Item 1</a></td>
          <td><a href="http://zurb.com">Item 2</a></td>
        </tr>
      </table>
    HTML

    compare(input, expected)
  end
end
