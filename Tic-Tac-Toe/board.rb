# The Board class represents a game board for the game Tic-Tac-Toe
# It handles the placement and management of game pieces.
#
# Example usage:
# board = Board.new
# board.update_positions(position, marker)

# frozen_string_literal: true

class Board
  def initialize
    @positions = Array.new(9, '-')
  end

  def draw_board
    puts ' _________________ '
    puts '|     |     |     |'
    puts "|  #{@positions[0]}  |  #{@positions[1]}  |  #{@positions[2]}  |"
    puts '|_____|_____|_____|'
    puts '|     |     |     |'
    puts "|  #{@positions[3]}  |  #{@positions[4]}  |  #{@positions[5]}  |"
    puts '|_____|_____|_____|'
    puts '|     |     |     |'
    puts "|  #{@positions[6]}  |  #{@positions[7]}  |  #{@positions[8]}  |"
    puts '|_____|_____|_____|'
  end

  def valid_move?(position)
    position.between?(0, 8) && @positions[position] == '-'
  end

  def update_position(position, marker)
    @positions[position] = marker if valid_move?(position)
  end

  def win?
    winning_combinations = [
      [0, 1, 2],  # Top row
      [3, 4, 5],  # Middle row
      [6, 7, 8],  # Bottom row
      [0, 3, 6],  # Left column
      [1, 4, 7],  # Middle column
      [2, 5, 8],  # Right column
      [0, 4, 8],  # Diagonal from top-left to bottom-right
      [2, 4, 6]   # Diagonal from top-right to bottom-left
    ]

    winning_combinations.each do |combo|
      if @positions[combo[0]] != '-' &&
         @positions[combo[0]] == @positions[combo[1]] &&
         @positions[combo[1]] == @positions[combo[2]]
        return true
      end
    end
    false
  end

  def full?
    !@positions.include?('-')
  end
end
