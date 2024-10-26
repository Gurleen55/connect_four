# frozen_string_literal: true

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
      @input = user_input(player) - 1
      break if update_grid?(@input, player)
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

  def selected_column_cell_index(input, grid)
    column = grid[input]
    column.each_with_index do |cell, index|
      return index unless cell == ' '
    end
  end

  # def check_winner?
  # end

  def vertical_check?(input, grid, player)
    cell_index = selected_column_cell_index(input, grid)
    3.times do |i|
      return false unless grid[input][cell_index + i + 1] == player.symbol
    end
    true
  end

  def horizontal_check?(input, grid, player) # rubocop:disable Metrics/MethodLength
    cell_index = selected_column_cell_index(input, grid)
    consecutive_symbol_counter = 0
    grid.transpose[0].size.times do |i|
      if grid[i][cell_index] == player.symbol
        consecutive_symbol_counter += 1
        return true if consecutive_symbol_counter == 4
      else
        consecutive_symbol_counter = 0
      end
    end
    false
  end

  def diagonal_check?(input, grid, player)
    cell_index = selected_column_cell_index(input, grid)
    consecutive_symbol_counter = 0
    7.times do |i|
      row = input + 3 - i
      column = cell_index - 3 + i
      if row.between?(0, grid.size - 1) && column.between?(0, grid[0].size - 1)
        if grid[row][column] == player.symbol
          consecutive_symbol_counter += 1
          return true if consecutive_symbol_counter == 4
        else
          consecutive_symbol_counter = 0
        end
      end
    end
    consecutive_symbol_counter = 0
    7.times do |i|
      row = input - 3 + i
      column = cell_index - 3 + i
      if row.between?(0, grid.size - 1) && column.between?(0, grid[0].size - 1)
        if grid[row][column] == player.symbol
          consecutive_symbol_counter += 1
          return true if consecutive_symbol_counter == 4
        else
          consecutive_symbol_counter = 0
        end
      end
    end
    false
  end
end
