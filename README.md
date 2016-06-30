# Inky

Inky is an HTML-based templating language that converts simple HTML into complex, responsive email-ready HTML. Designed for [Foundation for Emails](http://foundation.zurb.com/emails), a responsive email framework from [ZURB](http://zurb.com).

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

Make sure that the stylesheet included in your email layout imports the Foundation for Emails styles:

```scss
// my_awesome_emails_stylesheet.scss
@import "foundation-emails";
```

Rename your email templates to use the `.inky` file extension. For example:

```
welcome.html      => welcome.html.inky
pw_reset.html.erb => pw_reset.html.inky
```

You're all set!

** (The majority of email clients ignore linked stylesheets. By inlining your referenced styles, `premailer-rails` lets you keep your markup and stylesheets in separate files.)

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
