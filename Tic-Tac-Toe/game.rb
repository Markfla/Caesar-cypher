# The Game class represents the game logic for the game Tic-Tac-Toe

# frozen_string_literal: true

require_relative 'board'

class Game
  def initialize(player1, player2)
    @p1 = player1
    @p2 = player2
    @current_player = @p1
    @board = Board.new
    @game_over = false
    game_loop
  end

  def game_loop
    until @game_over
      @board.draw_board
      puts "#{@current_player}, it's your turn."
      make_move

      @game_over = check_game_over

      swap_player unless @game_over
    end
    puts 'Game over!'
  end

  def make_move
    puts 'Enter position (0-8): '
    position = gets.chomp.to_i
    if @board.valid_move?(position)
      @board.update_position(position, current_marker)
    else
      puts 'Invalid move, try again.'
      make_move
    end
  end

  def check_game_over
    @board.win? || @board.full?
  end

  def swap_player
    @current_player = @current_player == @p1 ? @p2 : @p1
  end

  def current_marker
    @current_player == @p1 ? 'X' : 'O'
  end
end
