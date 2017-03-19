class Board < ActiveRecord::Base
  has_one :player1, class_name: 'Player'
  has_one :player2, class_name: 'Player'
  has_one :current_player, class_name: 'Player'

  attr_reader :current_player, :player_one, :player_two
  after_initialize :set_player

  def set_player
    #self.current_player_id = Player.where(board: self).first.id
  end

  def swap_players
    if @current_player == self.player1
      @current_player = self.player2
    else
      @current_player = self.player1
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
      column_discs.minimum('row')
    end
  end

  def add_disc(column)
    unless (row = find_open_row(column)).nil?
      Disc.create(column: column, row: row, player_id: @current_player)
      self.swap_players
    else
      nil
    end
  end

  def slot_owner(column, row)
    # if self.player1.has_disc?(column, row)
    #   self.player1
    # elsif self.player2.has_disc?(column, row)
    #   self.player2
    # else
    #   nil
    # end
    Disc.where(colun: column, row: row).first.player
  end

  #move to controller
  def drop_disc(column)
    bottom_row = find_bottom_row(column)
    return nil if bottom_row < 0
    @current_player.add_disc(column, bottom_row)
    @last_disc = {player: @current_player, opponent: @current_player.opponent, color: @current_player.color, coords: [column, bottom_row]}
    @count += 1
  end

  #move to controller
  def check_game_over
    if @last_disc[:player].detect_win(@last_disc[:coords][0], @last_disc[:coords][1])
      @last_disc[:player]
    elsif count >= 49
      :tie
    else
      false
    end
  end

end