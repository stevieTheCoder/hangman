module Hangman

	require "yaml"

	class Game
		attr_accessor :secret_word, :guess_count, :guess, :current_guesses, :previous_guesses
		def initialize
			@secret_word = secret_word_setter
			@guess_count = 0
			@guess = guess
			@current_guesses = initial_construct
			@previous_guesses = []
		end

		def load_game
			YAML.load_file("./lib/hangman/save_files/hangman.yml").play
		end

		def load_game_message
			"The last game save has been loaded"
		end

		def new_game_message
			"A secret word has been created, you have 10 attempts to guess the word"
		end

		def start
			puts "\n######################\n# Welcome to Hangman #\n######################\n"
			puts "\nYou can save the game at any time by typing 'save'"
			puts "\nWould you like to load a previous game? (Y/N)"

			load_game_response = capture_user_input

			if load_game_response.upcase == "Y"
				puts load_game_message
				load_game
			else 
				puts new_game_message
				puts initial_construct.join
				play
			end
		end

		def play
			while true
				puts ""
				puts number_of_guesses_remaining
				puts ""
				puts guess_feedback.join
				puts solicit_move
				@guess = capture_user_input
				if guess == "save"
					save_game
					puts save_message
					return false
				end
				puts ""
				puts guess_feedback.join
				puts ""
				puts "you have made the following guesses so far: #{construct_previous_guesses.join(" ")}"
				guess_counter
				if game_over
					puts game_over_message
					return false
				end
			end
		end

		def solicit_move
			"Please type a letter and press enter to make a guess"
		end

		def capture_user_input(input = gets.chomp)
			input
		end

		def save_game
			File.open("./lib/hangman/save_files/hangman.yml", 'w') { |f| YAML.dump(self, f) }
		end

		def save_message
			"File saved, now closing the game"
		end

		def guess_counter
			@guess_count += 1 unless secret_word.include? guess || @guess = "save"
		end

		def guess_feedback
			result = []
			current_guesses.each_with_index do |char, index|
				if secret_word[index] == guess
					result << secret_word[index]
				else
					result << char
				end
			end
			@current_guesses = result
			current_guesses
		end

		def construct_previous_guesses
			if previous_guesses.include? guess
				previous_guesses
			else
				@previous_guesses << guess
			end
			previous_guesses
		end

		def number_of_guesses_remaining
			"You have #{10 - guess_count} guesses remaining"
		end

		def dictionary_location
			"./lib/hangman/5desk.txt"
		end

		def array_of_dictionary_words
			words = File.readlines(dictionary_location)
			words.map { |word| word.chomp }
		end

		def words_between_5_and_12_characters
			array_of_dictionary_words.delete_if { |word| word.length <= 5 || word.length >=12 }
		end

		def secret_word_setter
			words_between_5_and_12_characters.sample.chars
		end

		def initial_construct
			Array.new(secret_word.length) {"_"}
		end

		def game_over
			return :winner if winner?
			return :lose if lose?
			false
		end

		def game_over_message
			return "You win!" if game_over == :winner
			return "You have run out of guesses, you lose!" if game_over == :lose
		end

		def winner?
			return false if current_guesses.include?("_")
			true
		end

		def lose?
			return true if guess_count == 10
			false
		end
	end
end