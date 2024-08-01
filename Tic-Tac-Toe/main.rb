# frozen_string_literal: true

require_relative 'game'

puts "\nTic-Tac-Toe Game Init"

puts 'Player 1, what is your name?'
player1 = gets.chomp
puts "\nWelcome #{player1}"

puts "\nPlayer 2, what is your name?"
player2 = gets.chomp
puts "\nWelcome #{player2}"

puts "\nGame ready, press any key to begin"
gets

Game.new(player1, player2)
