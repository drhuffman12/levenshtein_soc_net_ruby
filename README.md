# Levenshtein Social Network (Ruby implementation)

Homepage: https://github.com/drhuffman12/levenshtein_soc_net_ruby

Calculate the 'social network' quantity for a group of words based on their Levenshtein Distance and Letter Histograms.

* See:
  - [the_challenge/CHALLENGE_RULES.md](the_challenge/CHALLENGE_RULES.md).
  - [the_challenge/MY_CONCEPT.md](the_challenge/MY_CONCEPT.md).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'levenshtein_soc_net_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install levenshtein_soc_net_ruby

## Usage

```ruby
net = LevenshteinSocNetRuby.new(input_file_path, max_lines)
net.run

# Then, either of the following:
net.soc_net_for_test_words
net.save(output_file_path) # saves net.soc_net_for_test_words to output_file_path
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/levenshtein_soc_net_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

