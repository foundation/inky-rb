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

## Installation

Add this line to your application's Gemfile:

    $ gem 'inky-rb', require: 'inky'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inky-rb

## Usage

Inky can be embedded into your asset pipeline, combining with premailer to let you generate amazing HTML emails without the nightmare of table-based email development.

Simply use the file extension `.inky` and make sure your email layout includes a scss file that includes the foundation-emails styles.
```
@import 'foundation-emails'
```

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
