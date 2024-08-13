# Method to create a secret word for the game
def make_secret_word
  words = File.readlines("Hangman/google-10000-english-no-swears.txt").map(&:chomp)
  filtered_words = words.select { |word| word.length.between?(5, 12) }
  filtered_words.sample
end

# Method to start/play the game with the secret word
def game(secret_word)
  guess_string = "_" * secret_word.length
  guesses = 10
  guessed_letters = []

  until guesses <= 0 || guess_string == secret_word
    puts "\nWord to guess: #{guess_string}"
    puts "Remaining guesses: #{guesses}"
    puts "Guessed letters: #{guessed_letters.join(', ')}"
    
    puts "\nEnter your guess:"
    guess = gets.chomp.downcase

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

# Hangman game initialization and start
puts "\n======================================"
puts "\n             HangMan INIT             "
puts "\n======================================"

puts "\nGame ready, Press enter to begin\n\n"
gets

# Start the game with a secret word
game(make_secret_word)
