require_relative 'grid'
require_relative 'player'

# this will implement connect four game
class ConnectFour
  attr_accessor :board

  def initialize(player1, player2, board = Grid.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @board.make_grid
    @board.assign_grid
  end

  def user_input(player)
    puts "#{player.name}, please choose a number between 1 - 10"
    choice = nil
    # this loop will ensure the valid input is provided
    loop do
      choice = gets.chomp.to_i
      break if choice.between?(1, 10)

      puts 'invalid choice, the number should be between 1 -10'
    end
    # return the choice to used after
    choice
  end

  def turn(player)
    loop do
      input = user_input(player)
      break if update_grid?(input - 1, player)
    end
    @board.display_grid
  end

  def update_grid?(input, player)
    # this will select the first column
    column = board.grid[input]
    (column.size - 1).downto(0).each do |index|
      if column[index] == ' '
        column[index] = player.symbol
        return true
      end
    end
    puts 'lane full, please try different lane'
  end

  def start_game
    @board.display_grid
    number_of_turns = board.grid.flatten.size
    number_of_turns.times do |i|
      player = i.even? ? @player1 : @player2
      turn(player)
    end
  end

  def identify_cell(input, grid)
    column = grid[input]
    column.each do |cell|
      return cell unless cell == ' '
    end
  end
  # def check_winner?

  # end
end
