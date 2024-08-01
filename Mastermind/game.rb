require_relative 'board'

class Game
  def initialize(choice)
    @codePegs = ['green', 'purple', 'blue', 'yellow', 'orange', 'black']
    @board = Board.new
    @game_over = false
    if choice == 'c'
      @chooser = 'Player'
      player_make_secret
      # computer_game_loop # Uncomment if you plan to implement this
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
    puts "To create a secret you must enter 4 colours from the list\n"
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

  def player_game_loop
    win = false
    (1..10).each do |row|
      code = create_code
      feedback_pegs = check_positions(code)
      @board.set_guess(row, code, feedback_pegs)
      if feedback_pegs[:correct_position] == 4
        win = true
        break
      end
    end
    if win 
      puts "\nCONGRATULATIONS!!\nYou won the game!"
    else 
      puts "\nUnfortunately you have lost the game :("
      puts "\nThe code was : #{@secret}"
    end
  end

  def check_positions(code)
    feedback_pegs = {
      correct_position: 0,
      correct_color: 0
    }
    
    secret_checked = Array.new(4, false)
    code_checked = Array.new(4, false)
  
    # First pass: count correct positions
    code.each_with_index do |code_color, code_index|
      if @secret[code_index] == code_color
        feedback_pegs[:correct_position] += 1
        secret_checked[code_index] = true
        code_checked[code_index] = true
      end
    end
  
    # Second pass: count correct colors in wrong positions
    code.each_with_index do |code_color, code_index|
      next if code_checked[code_index] # Skip if already counted as correct position
  
      @secret.each_with_index do |secret_color, secret_index|
        if code_color == secret_color && !secret_checked[secret_index] && !code_checked[code_index]
          feedback_pegs[:correct_color] += 1
          secret_checked[secret_index] = true
          break
        end
      end
    end
  
    feedback_pegs
  end
  
end
