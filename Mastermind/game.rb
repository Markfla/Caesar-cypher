# Game Initialization
# This class represents the game Mastermind
# instantiate with 'c' to choose the code and 
# have it cracked in under 5 turns
# instantiate with 'g' to guess at the computers secret code

require_relative 'board'

class Game
  def initialize(choice)
    @codePegs = ['green', 'purple', 'blue', 'yellow', 'orange', 'black']
    @board = Board.new
    @game_over = false
    @win = false

    if choice == 'c'
      @chooser = 'Player'
      player_make_secret
      computer_game_loop
    else
      @chooser = 'Computer'
      computer_make_secret
      player_game_loop
    end
  end

  def computer_make_secret
    @secret = Array.new(4) { @codePegs.sample }
  end

  def player_make_secret
    puts "To create a secret you must enter 4 colors from the list\n"
    @secret = create_code
  end

  def create_code
    puts "\nCode pegs:\n#{@codePegs.join(', ')}\nPlease enter one-by-one when prompted\n"
    puts "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
    code = Array.new(4)

    4.times do |i|
      loop do
        puts "\nPlease enter peg ##{i + 1}"
        input = gets.chomp.downcase

        if @codePegs.include?(input)
          code[i] = input
          break
        else
          puts "\nIncorrect choice, please choose from the following options\n#{@codePegs.inspect}"
        end
      end
    end
    code
  end

  def computer_game_loop
    puts "\n10 turns? Donald_Knuth_ai_3000 (TM) only needs 5\n"
    code = ['green', 'green', 'purple', 'purple'] # Optimal start
    combinations = create_combinations_set

    (1..10).each do |row|
      feedback_pegs = check_positions(code, @secret)
      @board.set_guess(row, code, feedback_pegs)
      
      if checkwin(feedback_pegs)
        puts "Donald_Knuth_ai_3000 (TM) has cracked the code!"
        break
      end

      combinations = remove_non_matching_from_set(combinations, code, feedback_pegs)
      code = choose_next_guess(combinations)
    end
  end

  def remove_non_matching_from_set(combinations, last_guess, target_feedback_pegs)
    combinations.delete_if do |code|
      feedback = check_positions(last_guess, code)
      feedback != target_feedback_pegs
    end
    combinations
  end

  def player_game_loop
    (1..10).each do |row|
      code = create_code
      feedback_pegs = check_positions(code, @secret)
      @board.set_guess(row, code, feedback_pegs)
      
      if checkwin(feedback_pegs)
        puts "CONGRATULATIONS!!\nYou won the game!"
        break
      end

      puts "Unfortunately, that was not correct. Try again."
    end

    puts "The game is over. The secret code was: #{@secret}" unless @win
  end

  def checkwin(feedback_pegs)
    if feedback_pegs[:correct_position] == 4
      @win = true
      true
    else
      false
    end
  end

  def create_combinations_set
    @codePegs.repeated_permutation(4).to_a
  end

  def choose_next_guess(combinations)
    minimax_scores = {}

    combinations.each do |guess|
      scores = Hash.new(0)
      
      combinations.each do |possible_code|
        feedback = check_positions(guess, possible_code)
        scores[feedback] += 1
      end

      max_score = scores.values.max
      minimax_scores[guess] = max_score
    end

    best_guess = minimax_scores.min_by { |_, v| v }[0]
    best_guess
  end

  def check_positions(guess, secret)
    feedback_pegs = {
      correct_position: 0,
      correct_color: 0
    }

    secret_checked = Array.new(4, false)
    guess_checked = Array.new(4, false)

    guess.each_with_index do |guess_color, guess_index|
      if secret[guess_index] == guess_color
        feedback_pegs[:correct_position] += 1
        secret_checked[guess_index] = true
        guess_checked[guess_index] = true
      end
    end

    guess.each_with_index do |guess_color, guess_index|
      next if guess_checked[guess_index]

      secret.each_with_index do |secret_color, secret_index|
        if guess_color == secret_color && !secret_checked[secret_index]
          feedback_pegs[:correct_color] += 1
          secret_checked[secret_index] = true
          break
        end
      end
    end

    feedback_pegs
  end
end
