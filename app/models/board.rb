require 'singleton'

class Board
  include Singleton
  attr_reader :height, :width, :grid, :current_player, :player_one, :player_two

  def initialize(height = 7, width = 7)
    @height = height
    @width = width
    @player_one = Player.new(1)
    @player_two = Player.new(2)
    @current_player = [@player_one, @player_two].sample
    @grid = Array.new(height){ Array.new(width) }
  end

  def through_grid
    @width.times do |column|
      @height.times do |row|
        yield(column, row)
      end
    end
  end

  def reset
    @grid = Array.new(height){ Array.new(width) }
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

  def find_bottom_row(column)
    @height.times do |row|
      return (row - 1) if @grid[column][row]
    end
    @height - 1
  end

  def swap_player
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  def drop_disc(column, player = @current_player)
    bottom_row = find_bottom_row(column)
    return nil if bottom_row < 0
    @grid[column][bottom_row] = player
    @current_player.add_disc(column, bottom_row)
    {player: @current_player, coords: [column, bottom_row]}
  end

end