# Easy prof

Profiling without pain.

Easy prof was created to reduce the time between identifying a slow
method and getting the data on the cause of the problem. It
leverages the power of the ruby-prof gem to give detailed method
information without the need to remember how to set it up and with
minimal impact on your code.

## Usage

    require 'easy-prof'

    class ImportantStuff
      include EasyProf
      instrument :troublesome_method

      def troublesome_method
        # code, y u so slow?
      end
    end

That's it! When `ImportantStuff#troublesome_method` is called RubyProf
will be loaded and profile everything for you.

By default, the profile will be output to 'tmp/profile-graph.html' and
RubyProf::WALL_TIME will be used to measure method times. You can
override these by passing options to `instrument`

    instrument :troublesome_method, :profile_location => 'path-to-output.html', :measure_mode => RubyProf::WALL_TIME

## Installation

Add this line to your application's Gemfile:

    gem 'easy-prof'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy-prof

## Contributors
* Lucas Maxwell
* Sean Caffery

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
