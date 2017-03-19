class Board < ActiveRecord::Base
  has_many :discs, through: :players

  attr_reader :player1, :player2, :current_player_id

  def set_players
    players = Player.where(board: self)
    @player1 = players.first
    @player2 = players.last
    @current_player_id = players.first.id
  end

  def swap_players
    if @current_player_id == @player1.id
      @current_player_id = @player2.id
    else
      @current_player_id = @player1.id
    end
  end

  def reset
    self.player1.discs.delete_all
    self.player2.discs.delete_all
  end

  def find_open_row(column)
    column_discs = Disc.where(column: column)
    if column_discs.empty?
      6
    elsif column_discs.size == 7
      nil
    else
      column_discs.minimum('row') - 1
    end
  end

  def add_disc(column)
    set_players if @current_player_id.nil?
    unless (row = find_open_row(column)).nil?
      Disc.create(column: column, row: row, player_id: @current_player_id)
      swap_players
    else
      nil
    end
  end

  def slot_owner(column, row)
    Disc.where(column: column, row: row).first.player
  end

  #move to controller
  def check_game_over
    disc = Disc.last
    if disc.player.detect_win(disc.column, disc.row)
      disc.player
    elsif Disc.count == 49
      :tie
    else
      nil
    end
    #
    # if @last_disc[:player].detect_win(@last_disc[:coords][0], @last_disc[:coords][1])
    #   @last_disc[:player]
    # elsif count >= 49
    #   :tie
    # else
    #   false
    # end
  end

end