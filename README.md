# Contributor

Contributor is tiny calculator of git log.

- Print commit
- Print increase and decrease lines

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'contributor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install contributor

## Usage

### Initialize configuration

You need to manage your repository configuration.

```
# Create configuration.yml
bundle exec contributor --init
```

### Run

```
bundle exec contributor --configuration your/configuration.yml --repository your/repository/path
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alpaca-tc/contributor/issues.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
