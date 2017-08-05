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

		def play
			puts "Welcome to Hangman"
			puts ""
			puts "A secret word has been created, you have 10 attempts to guess the word"
			puts initial_construct.join
			while true
				puts ""
				puts solicit_move
				@guess = capture_user_input
				save_game
				puts ""
				puts guess_feedback.join
				puts ""
				puts "you have made the following guesses so far: #{construct_previous_guesses.join(" ")}"
				guess_counter
				puts number_of_guesses_remaining
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
			if @guess = "save"
				#code to save game
			else
				#figure it out
		end

		def guess_counter
			@guess_count += 1 unless secret_word.include? guess
		end

		def save_file
			file.open("./lib/hangman/save_file.yml", 'w') { |file| file.write(YAML.dump())}
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