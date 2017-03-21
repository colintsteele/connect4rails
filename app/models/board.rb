class Board < ActiveRecord::Base
  has_one :player1, -> { where id: 1}, class_name: "Player"
  has_one :player2, -> { where id: 2}, class_name: "Player"
  has_many :discs, through: :players

  def current_player_id
    case Disc.count
      when 0
        Player.first.id
      when 1
        Player.last.id
      else
        Disc.all[-2].player.id
    end
  end

  def reset
    Disc.delete_all
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
    row = find_open_row(column)
    return nil if row.nil?
    Disc.create(column: column, row: row, player_id: current_player_id)
  end

  def slot_owner(column, row)
    Disc.where(column: column, row: row).first.player
  end

  def check_game_over
    disc = Disc.last
    if disc.player.detect_win(disc.column, disc.row)
      disc.player
    elsif Disc.count == 49
      :tie
    else
      nil
    end
  end

end