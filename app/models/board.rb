require 'singleton'

class Board
  include Singleton
  attr_reader :height, :width, :grid,

  def initialize(height = 7, width = 7)
    @height = height
    @width = width
    @grid = Array.new(height){ Array.new(width) }
  end

  def through_grid
    @width.times do |column|
      @height.times do |row|
        yield(column, row)
      end
    end
  end

  def print_board
    print "\n"
    through_grid do |column, row|
      case @grid[row][column]
        when 1
          print("[X]")
        when 2
          print("[O]")
        else
          print("[-]")
      end
      print "\n" if row == width - 1
    end
  end

  def find_bottom_row
    @height.times do  |row|
      return (row - 1) if @grid[column][row]
    end
    @height - 1
  end


end