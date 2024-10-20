require_relative "grid"
require_relative "player"

# this will implement connect four game
class ConnectFour
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Grid.new
  end

  def user_input
    puts "please choose a number between 1 - 10"
    choice = nil
    loop do
      choice = gets.chomp.to_i
      break if choice.between?(1, 10)

      puts "invalid choice, please choose a number between 1 - 10"
    end
    choice
  end
end
