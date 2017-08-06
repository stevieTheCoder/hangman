module Hangman

	require "yaml"

	class Game

		attr_accessor :secret_word, :guess_count, :guess, :current_guesses, :previous_guesses

		def initialize
			@secret_word = secret_word_setter
			@guess_count = 0
			@guess = guess
			@current_guesses = initial_board_construct
			@previous_guesses = []
		end

		def start
			puts "\n######################\n# Welcome to Hangman #\n######################\n"
			puts %Q{
        ____
       |/   |
       |    O
       |   /|\\
       |    |
       |   / \\
   ____|____    
		}
			puts "\nYou can save the game at any time by typing 'save'"
			puts "\nWould you like to load the previous game save? (Y/N)"

			load_game_response = capture_user_input

			if load_game_response.upcase == "Y"
				load_game_message
				load_game
			else 
				new_game_message
				play
			end
		end

		def play
			while true
				show_hangman
				display_board
				number_of_guesses_remaining_message
				previous_guesses_feedback_message
				solicit_move_message

				@guess = capture_user_input

				if guess == "save"
					save_game
					save_message
					return false
				end

				update_board
				update_previous_guesses
				update_guess_counter

				if game_over
					game_over_message
					return false
				end
			end
		end

		def load_game
			YAML.load_file("./lib/hangman/save_files/hangman.yml").play
		end

		def save_game
			File.open("./lib/hangman/save_files/hangman.yml", 'w') { |f| YAML.dump(self, f) }
		end

		def load_game_message
			puts "\nThe last game save has been loaded."
		end

		def new_game_message
			puts "\nA random word has been created for you to guess.\n\nThe word is #{secret_word.length} letters in length."
		end

		def save_message
			puts "\nFile saved, now closing the game."
		end

		def number_of_guesses_remaining_message
			puts "\nYou have #{10 - guess_count} guesses remaining."
		end

		def solicit_move_message
			puts "\nPlease type a letter or guess the word and then press enter."
		end

		def previous_guesses_feedback_message
			puts "\nYou have made the following guesses: #{previous_guesses.join(', ')}" unless previous_guesses.empty?
		end

		def capture_user_input(input = gets.chomp)
			input.downcase
		end

		def update_guess_counter
			@guess_count += 1 unless secret_word.include? guess || @guess = "save"
		end

		def update_board
			result = []
			current_guesses.each_with_index do |char, index|
				if secret_word[index] == guess
					result << secret_word[index]
				else
					result << char
				end
			end
			@current_guesses = result
		end

		def display_board
			puts ""
			puts current_guesses.join
		end

		def update_previous_guesses
			if previous_guesses.include? guess
				previous_guesses
			else
				@previous_guesses << guess
			end
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

		def initial_board_construct
			Array.new(secret_word.length) {"_"}
		end

		def game_over
			return :winner if winner?
			return :lose if lose?
			false
		end

		def game_over_message
			puts "You have correctly guessed the word: #{secret_word.join}, you win!" if game_over == :winner
			puts "You have run out of guesses, you lose!" if game_over == :lose
		end

		def winner?
			return true if guess == secret_word.join
			return false if current_guesses.include?("_")
			true
		end

		def lose?
			return true if guess_count == 10
			false
		end

		def show_hangman
		case guess_count
			when 0
				puts %Q{
		        





		   ____|____    
				  }
			  when 1
			  	puts %Q{
		        
		       |
		       |
		       |   
		       |    
		       |   
		   ____|____    
				}
			  when 2
					puts %Q{
		        ____
		       |/   
		       |
		       |
		       |    
		       |   
		   ____|____    
				}
			  when 3
					puts %Q{
		        ____
		       |/   |
		       |
		       |
		       |
		       |    
		   ____|____    
				}
			  when 4
					puts %Q{
		        ____
		       |/   |
		       |    O
		       |
		       |
		       |   
		   ____|____    
				}
			  when 5
					puts %Q{
		        ____
		       |/   |
		       |    O
		       |    |
		       |
		       |   
		   ____|____    
				}
			  when 6
					puts %Q{
		        ____
		       |/   |
		       |    O
		       |    |
		       |    |
		       |
		   ____|____    
				}

				when 7
					puts %Q{
		        ____
		       |/   |
		       |    O
		       |   /|
		       |    |
		       |   
		   ____|____    
				}
			  when 8
					puts %Q{
		        ____
		       |/   |
		       |    O
		       |   /|\\
		       |    |
		       |
		   ____|____    
				}

			  when 9
					puts %Q{
		        ____
		       |/   |
		       |    O
		       |   /|\\
		       |    |
		       |   /
		   ____|____    
				}
			  when 10
					puts %Q{
		        ____
		       |/   |
		       |    O
		       |   /|\\
		       |    |
		       |   / \\
		   ____|____    
				}
	  		end
		end
	end
end