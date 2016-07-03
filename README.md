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
// app/assets/stylesheets/your_emails_stylesheet.scss

@import "foundation-emails";
```

Rename your email templates to use the `.inky` file extension. Note that you'll still be able to use ERB within the `.inky` templates:

```
welcome.html      => welcome.html.inky
pw_reset.html.erb => pw_reset.html.inky
```

Ensure your mailer layout has the following structure:

```html
<!-- app/views/layouts/your_mailer_layout.html.erb -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- Enables media queries -->
    <meta name="viewport" content="width=device-width"/>
    <!-- Link to the email's CSS, which will be inlined into the email -->
    <%= stylesheet_link_tag "your_emails_stylesheet" %>
  </head>

  <body>
    <table class="body" data-made-with-foundation>
      <tr>
        <td class="center" align="center" valign="top">
          <center>
            <%= yield %>
          </center>
        </td>
      </tr>
    </table>
  </body>
</html>
```

You're all set!

** The majority of email clients ignore linked stylesheets. By using a CSS inliner like `premailer-rails` or `roadie`, you're able to leave your stylesheets in a separate file, keeping your markup lean.

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
