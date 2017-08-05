require "spec_helper"

module Hangman
	RSpec.describe Game do 

		context "#dictionary_location" do
			it "returns the location of the dictionary file" do
				location = "./lib/hangman/5desk.txt"
				game = Game.new
				expect(game.dictionary_location).to eq location
			end
		end

		context "#array_of_dictionary_words" do
			it "returns an array of words in a passed textfile" do
				test_array = %w[This Is A Test]
				test_dictionary_location = "./lib/hangman/test.txt"
				game = Game.new
				allow(game).to receive(:dictionary_location) { test_dictionary_location }
				expect(game.array_of_dictionary_words).to eq test_array
			end
		end

		context "#secret_word_setter" do
			it "returns a secret word array between 5 and 12 characters in length" do
				game = Game.new
				expect(game.secret_word_setter.length).to be_between(5, 12)
			end
		end

		context "#guess_feedback" do
			it "returns an array of the current game position" do
				game = Game.new
				expected = ["_", "e", "_", "_"]
				allow(game).to receive(:guess) { "E" }
				allow(game).to receive(:secret_word) { ["T", "e", "s", "t"] }
				allow(game).to receive(:current_guesses) { ["_", "_", "_", "_"] }
				expect(game.guess_feedback).to eq expected
			end
		end

		context "#initial_construct" do
			it "creates an array of '_' for each character in the secret word" do
				test_word = ["T", "e", "s", "t"]
				expected = ["_", "_", "_", "_"]
				game = Game.new
				allow(game).to receive(:secret_word) { test_word }
				expect(game.initial_construct).to eq expected
			end
		end
	end
end

