require_relative "grid"
require_relative "player"

# this will implement connect four game
class ConnectFour
  attr_accessor :board

  def initialize(player1, player2, board = Grid.new)
    @player1 = player1
    @player2 = player2
    @board = board
  end

  def grid_initialzation
    @board.make_grid
    @board.assign_grid
  end

  def user_input
    puts "please choose a number between 1 - 10"
    choice = nil
    # this loop will ensure the valid input is provided
    loop do
      choice = gets.chomp.to_i
      break if choice.between?(1, 10)

      puts "invalid choice, please choose a number between 1 - 10"
    end
    # return the choice to used after
    choice
  end

  def turn(player)
    puts player.name
    loop do
      input = user_input
      break if update_grid?(input - 1, player)
    end
    @board.display_grid
  end

  def update_grid?(input, player)
    # this will select the first column
    column = board.grid[input]
    (column.size - 1).downto(0).each do |index|
      if column[index] == " "
        column[index] = player.symbol
        return true
      end
    end
    puts "lane full, please try different lane"
  end
end
