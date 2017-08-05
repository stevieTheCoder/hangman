## GOALS

When a new game is started script should load dictionary and randomly select a word between 5 and 12 characters long for the secret word.

when new game is created.

read in file
1 word per line so readlines will create an array of words.
sort array
remove words over 12 characters
remove words with less than 5 characters
select word at random from array and set to secret word

Display which letters have been succesfully chosen and those which are unsuccesful.

solicit guesses - capture user input

compare guess string to secret word using contain?



Display how many guesses the player has left, the player will lose if out of guesses.

every turn the player can make a guess of a letter, it should be case insensitive.

at the start of every turn instead of making a guess the player should have the option to save the game.

when the program first loads the player should have the options to load a saved game.




# Hangman

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hangman`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hangman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hangman

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hangman.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
