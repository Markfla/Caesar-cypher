class Game
  def initialize(choice)
    @codePegs = ['green','purple','blue','yellow','orange','black']
    @choicePegs = ['white', 'red']
    if choice == 'c'
      @chooser = 'Player'
      player_make_secret
    else 
      @chooser = 'Computer'
      computer_make_secret
    end 

    #@board = Board.new
    @game_over = false
    #game_loop
  end

  def computer_make_secret
    @secret = Array.new(4) {@codePegs.sample}
    puts @secret
  end

  def player_make_secret
    puts "To create a secret you must enter 4 colours from the list\n"
    @secret = createCode
  end

  def createCode
    puts "#{@codePegs} \nPlease enter one-by-one when prompted\n"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
    code = Array.new(4)

    4.times do |i|
      loop do
        puts "\nPlease enter peg ##{i}"
        input = gets.chomp.downcase
        
        if @codePegs.include?(input)
          code[i] = input
          break
        else 
          puts "\nincorrect choice, please choose from the following options\n#{@codePegs.inspect}"
        end
      end
    end
    return code
  end
end