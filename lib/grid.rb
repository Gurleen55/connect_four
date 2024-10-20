# this will make a grid needed to play the game
class Grid
  attr_accessor :grid

  def initialize
    @grid = nil
  end

  def make_grid
    Array.new(10) { Array.new(8, " ") }
  end

  def assign_grid
    @grid = make_grid
  end

  def display_grid
    @grid.transpose.each do |row|
      puts row.join("|")
    end
  end
end
