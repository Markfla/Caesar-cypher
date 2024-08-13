require_relative 'gamestate'

# Method to create a secret word for the game
def make_secret_word
  words = File.readlines("google-10000-english-no-swears.txt").map(&:chomp)
  filtered_words = words.select { |word| word.length.between?(5, 12) }
  filtered_words.sample
end

def game(secret_word, load_game = false)
  if load_game
    # Load saved game
    game_state = GameState.load_from_file('saved_game.dat')
    secret_word = game_state.secret_word
    guess_string = game_state.guess_string
    guesses = game_state.guesses
    guessed_letters = game_state.guessed_letters
  else
    # Initialize new game
    guess_string = "_" * secret_word.length
    guesses = 10
    guessed_letters = []
  end

  until guesses <= 0 || guess_string == secret_word
    puts "\nWord to guess: #{guess_string}"
    puts "Remaining guesses: #{guesses}"
    puts "Guessed letters: #{guessed_letters.join(', ')}"
    puts "Enter your guess or type 'save' to save the game:"

    input = gets.chomp.downcase

    if input == 'save'
      puts "Saving game..."
      game_state = GameState.new(secret_word, guess_string, guesses, guessed_letters)
      game_state.save_to_file('saved_game.dat')
      puts "Game saved successfully!"
      next
    end

    guess = input

    if guessed_letters.include?(guess)
      puts "You already guessed that letter."
      next
    end

    guessed_letters << guess

    if secret_word.include?(guess)
      # Update guess_string with correct guesses
      secret_word.each_char.with_index do |char, i|
        if char == guess
          guess_string[i] = char
        end
      end
    else
      guesses -= 1
    end
  end

  if guess_string == secret_word
    puts "Congratulations! You've guessed the word: #{secret_word}"
  else
    puts "Out of guesses. The secret word was: #{secret_word}"
  end
end


puts "\n======================================"
puts "\n             HangMan INIT             "
puts "\n======================================"
puts "Would you like to load a saved game? (yes/no):"
choice = gets.chomp.downcase

if choice == 'yes'
  if File.exist?('saved_game.dat')
    puts "Loading saved game..."
    game(nil, true)  # Load saved game
  else
    puts "No saved game found. Starting a new game..."
    game(make_secret_word)
  end
else
  puts "\nGame ready, Press enter to begin\n\n"
  gets
  game(make_secret_word)
end
