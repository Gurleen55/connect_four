# frozen_string_literal: true

require_relative 'lib/connect_four'
require_relative 'lib/grid'
require_relative 'lib/player'

player1 = Player.new('Adam', 'X')
player2 = Player.new('Eve', 'O')
game = ConnectFour.new(player1, player2)
game.start_game
