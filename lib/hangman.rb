require_relative "./hangman/version"
require_relative "./hangman/game.rb"

module Hangman
  Hangman::Game.new.play
end
