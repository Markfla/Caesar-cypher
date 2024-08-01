class Board
  def initialize
    createBoard
  end

  def createBoard()
    # Initialize the board with 10 rows, each represented as a hash with guess and feedback
    @board = {}
    (1..10).each do |row|
      @board[row] = {
        guess: [nil, nil, nil, nil], 
        feedback: { correct_position: 0, correct_color: 0 } 
      }
    end
    printBoard
  end

  def printBoard
    puts "Mastermind Board:"
    puts "-" * 40 
    @board.each do |row_number, data|
      guess = data[:guess].map { |color| color.nil? ? "empty" : color.capitalize }.join(" | ")
      feedback = "Correct Positions: #{data[:feedback][:correct_position]}, Correct Colors: #{data[:feedback][:correct_color]}"
      puts "Row #{row_number.to_s.rjust(2)}: Guess - [#{guess}] | Feedback - [#{feedback}]"
    end
    puts "-" * 40 
  end

  def set_guess(row,code,feedback)
    @board[row][:guess] = code
    @board[row][:feedback] = feedback
    printBoard
  end

end

