class Board
  def initialize
    @positions = Array.new(9, '-')  
  end

  def draw_board
    puts " _________________ "
    puts "|     |     |     |"
    puts "|  #{@positions[0]}  |  #{@positions[1]}  |  #{@positions[2]}  |"
    puts "|_____|_____|_____|"
    puts "|     |     |     |"
    puts "|  #{@positions[3]}  |  #{@positions[4]}  |  #{@positions[5]}  |"
    puts "|_____|_____|_____|"
    puts "|     |     |     |"
    puts "|  #{@positions[6]}  |  #{@positions[7]}  |  #{@positions[8]}  |"
    puts "|_____|_____|_____|"
  end
end
