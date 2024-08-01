# Mastermind Game
# This class represents the main method for the game Mastermind
# It lets the user choose if they're creating or breaking the code


# frozen_string_literal: true

require_relative 'game'

puts "\nMastermind game init"

choice =''
until choice == 'g' or choice == 'c'
  puts "\nWill you be guessing or choosing? 'g' or 'c'"
  choice = gets.chomp.downcase
end

puts "\nGame ready, press any key to begin"
gets

Game.new(choice)