# SamsungWamApi

This gem provides wrapper around Samsung wireless audio multiroom control API. For more information about what commands your Samsung device support, see [this repo](https://github.com/bacl/WAM_API_DOC)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'samsung_wam_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install samsung_wam_api

## Usage

```ruby
require 'samsung_wam_api'
living_room_soundbar = SamsungWamApi::Device.new(ip: 192.168.0.1)
living_room_soundbar.power_on
living_room_soundbat.volume_up
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ares/samsung_wam_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

