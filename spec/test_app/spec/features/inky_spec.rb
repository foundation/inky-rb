require_relative '../helper'

def simple_container(text)
  <<-HTML
    <!DOCTYPE html>
    <html><body>
      <table class="container" align="center">
        <tbody><tr><td>
          #{text}
        </td></tr></tbody>
      </table>
    </body></html>
  HTML
end

describe 'Rails', type: :feature do
  it 'will convert .inky views' do
    visit "/inky/simple"

    expect_same_html page.html, simple_container('Simplistic example')
  end

  it "won't convert non .inky view" do
    visit "/inky/non_inky"

    expect_same_html page.html, <<-HTML
      <!DOCTYPE html>
      <html><body>
        <container/>
      </body></html>
    HTML
  end

  it "works for a partial convert non .inky view" do
    visit "/inky/non_inky?partial=inky_partial"

    expect_same_html page.html, <<-HTML
      <!DOCTYPE html>
      <html><body>
        <container>
          <table class="button"><tr><td>
            <table><tr><td><a href="bar">Click me</a></td></tr></table>
          </td></tr></table>
        </container>
      </body></html>
    HTML
  end

  it "works for an .inky layout" do
    visit "/inky/layout"

    expect_same_html page.html, <<-HTML
      <!DOCTYPE html>
      <html>
        <head>
          <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
          <title>inky : layout</title>
        </head>
        <body>
          <table class="container" align="center">
            <tbody><tr><td>
              Using inky layout
            </td></tr></tbody>
          </table>
        </body>
      </html>
    HTML
  end

  context "when configured to use a different template engine" do
    around do |spec|
      Inky.configure do |config|
        old = config.template_engine
        config.template_engine = :slim
        spec.run
        config.template_engine = old
      end
    end

    it "works for an slim .inky layout" do
      visit "/inky/slim"

      expect_same_html page.html, simple_container('Slim example')
    end
  end

  context "for an extension 'inky-<handler>'" do
    it "works when `handler` is registered after inky (like slim)" do
      visit "/inky/explicit_slim"

      expect_same_html page.html, simple_container('Explicit slim example')
    end

    it "works when `handler` is registered after inky (like builder)" do
      visit "/inky/explicit_builder"

      expect_same_html page.html, simple_container('Built with builder')
    end
  end
end
