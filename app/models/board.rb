require 'singleton'

class Board
  include Singleton
  attr_reader :height, :width, :current_player, :player_one, :player_two, :last_disc, :count

  def initialize(height = 7, width = 7, computer = false)
    @count = 0
    @height = height
    @width = width
    @player_one = Player.where(id: 1).first
    @player_two = Computer.where(id: 3).first
    @current_player = @player_one
  end

  def reset
    @player_one.reset
    @player_two.reset
    @count = 0
  end

  def slot_owner(column, row)
    if @player_one.has_disc?(column, row)
      @player_one
    elsif @player_two.has_disc?(column, row)
      @player_two
    else
      nil
    end

  end

  def find_bottom_row(column)
    @height.times do |row|
      return (row - 1) if slot_owner(column, row)
    end
    @height - 1
  end

  # def swap_player
  #   if @current_player == @player_one
  #     @current_player = @player_two
  #   else
  #     @current_player = @player_one
  #   end
  # end

  def swap_player
    if @current_player == @player_one
      @current_player = @player_two
      unless check_game_over
        @current_player.make_move
        swap_player
      end

    else
      @current_player = @player_one
    end
  end

  def drop_disc(column)
    bottom_row = find_bottom_row(column)
    return nil if bottom_row < 0
    @current_player.add_disc(column, bottom_row)
    @last_disc = {player: @current_player, opponent: @current_player.opponent, color: @current_player.color, coords: [column, bottom_row]}
    @count += 1
  end

  def check_game_over
    if Disc.last.player.detect_win(Disc.last.column, Disc.last.row)
      Disc.last.player
    elsif count >= 49
      :tie
    else
      false
    end
  end

end