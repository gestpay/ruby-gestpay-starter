# Ruby Gestpay Starter

This repository contains an example of a simple Gestpay Starter integration, written in Ruby.

This has been done by using:
- [**Sinatra**](http://www.sinatrarb.com/), an easy framework to create web applications in ruby.
- [**Savon**](http://savonrb.com/), a Ruby soap client.

This software has been developed with **Ruby 2.4**, but older versions should work too (as long as Sinatra supports it).

## Installation

This software is not a gem but just a standalone example.

To install, clone this repository and launch

```console
$ bundle install
```

in the Merchant Back-Office, setup these attributes:
- IP Address - the public IP your server is using
- success & failure response redirect url: `http://localhost:4567/response`

In the app code: 
- Open `./ruby_gestpay_starter/constants.rb` and update `SHOP_LOGIN` with your Shop Login.

## Usage

To start this app, simply launch

```console
$ ruby app.rb
```

Then, navigate to [`http://localhost:4567`](`http://localhost:4567`) to see the magic.

If you want to restart the app everytime you change something:

```console
$ gem install rerun
$ rerun 'ruby app.rb'
```


## Contributing, Typos, Fixes, just-say-Hi

Bug reports and pull requests are welcome here on GitHub!


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

