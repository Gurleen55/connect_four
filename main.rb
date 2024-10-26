# frozen_string_literal: true

require_relative 'lib/connect_four'
require_relative 'lib/grid'
require_relative 'lib/player'

player1 = Player.new('X')
player2 = Player.new('O')
puts "#{player1.name}, your symbol is #{player1.symbol}"
puts "#{player2.name}, your symbol is #{player2.symbol}"
game = ConnectFour.new(player1, player2)
game.start_game
