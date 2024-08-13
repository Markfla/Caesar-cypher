class GameState
  attr_accessor :secret_word, :guess_string, :guesses, :guessed_letters

  def initialize(secret_word, guess_string, guesses, guessed_letters)
    @secret_word = secret_word
    @guess_string = guess_string
    @guesses = guesses
    @guessed_letters = guessed_letters
  end

  # Serialize the game state to a file
  def save_to_file(filename)
    File.open(filename, 'wb') do |file|
      Marshal.dump(self, file)
    end
  end

  # Load the game state from a file
  def self.load_from_file(filename)
    File.open(filename, 'rb') do |file|
      Marshal.load(file)
    end
  end
end
