# this class would be used to make players needed for the game
class Player
  attr_reader :name, :symbol

  @@player_number = 1

  def initialize(symbol)
    puts "player #{@@player_number}, choose your name"
    @name = gets.chomp
    @symbol = symbol
    @@player_number += 1
  end
end
