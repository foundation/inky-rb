# Inky

[![Gem Version](https://badge.fury.io/rb/inky-rb.svg)](https://badge.fury.io/rb/inky-rb)

Inky is an HTML-based templating language that converts simple HTML into complex, responsive email-ready HTML. Designed for [Foundation for Emails](http://foundation.zurb.com/emails), a responsive email framework from [ZURB](http://zurb.com).

To include only the Foundation for Emails styles in your Asset Pipeline, without Inky, use the [**foundation_emails**](https://github.com/zurb/foundation-emails/#using-the-ruby-gem) gem.

Give Inky simple HTML like this:

```html
<row>
  <columns large="6"></columns>
  <columns large="6"></columns>
</row>
```

And get complicated, but battle-tested, email-ready HTML like this:

```html
<table class="row">
  <tbody>
    <tr>
      <th class="small-12 large-6 columns first">
        <table>
          <tr>
            <th class="expander"></th>
          </tr>
        </table>
      </th>
      <th class="small-12 large-6 columns first">
        <table>
          <tr>
            <th class="expander"></th>
          </tr>
        </table>
      </th>
    </tr>
  </tbody>
</table>
```

## Getting Started

Add the following gems to your Gemfile:

```ruby
gem 'inky-rb', require: 'inky'
# Stylesheet inlining for email **
gem 'premailer-rails'
```

Then execute:

```bash
bundle install
```

Run the following command to set up the required styles and mailer layout:

```bash
rails g inky:install
```

(You can specify the generated mailer layout filename like so: `rails g inky:install some_name` and also your prefered
markup language like: `rails g inky:install mailer_layout slim`)

Rename your email templates to use the `.inky` file extension. Note that you'll still be able to use your default
template engine within the `.inky` templates:

```
welcome.html      => welcome.html.inky
pw_reset.html.erb => pw_reset.html.inky
```

You're all set!

** The majority of email clients ignore linked stylesheets. By using a CSS inliner like `premailer-rails` or `roadie`, you're able to leave your stylesheets in a separate file, keeping your markup lean.

## Alternative template engine

If you do not use ERB for your views and layouts but some other markup like Haml or Slim, you can configure Inky to
use these languages. To do so, just set an initializer:

```ruby
# config/initializers/inky.rb
Inky.configure do |config|
  config.template_engine = :slim
end
```

Check [lib/generators/inky/templates/mailer_layout.html.slim](lib/generators/inky/templates/mailer_layout.html.slim)
for a Slim example.

## Custom Elements

Inky simplifies the process of creating HTML emails by expanding out simple tags like `<row>` and `<column>` into full table syntax. The names of the tags can be changed with the `components` setting.

Here are the names of the defaults:

```ruby
{
  button: 'button',
  row: 'row',
  columns: 'columns',
  container: 'container',
  inky: 'inky',
  block_grid: 'block-grid',
  menu: 'menu',
  center: 'center',
  callout: 'callout',
  spacer: 'spacer',
  wrapper: 'wrapper',
  menu_item: 'item'
}
```

## Programmatic Use

The Inky parser can be accessed directly for programmatic use.
