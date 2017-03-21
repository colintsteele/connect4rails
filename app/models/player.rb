class Player < ActiveRecord::Base
  belongs_to :board
  has_many :discs

  def reset
    Disc.where(player_id: self.id).delete_all
  end

  def has_disc?(column, row)
    discs = Disc.where(column: column, row: row)
    return false if discs.empty?
    discs.first.player == self
  end

  def detect_win(x, y)
    pi = Math::PI
    [2*pi, pi/4, pi/2, 3*pi/4].each do |direction|
      side_one = count_owned_adjacent(direction, x, y)
      side_two = count_owned_adjacent(direction - pi, x, y)
      return true if side_one + side_two >= 3
    end
    nil
  end

  def count_owned_adjacent(direction, column, row, count=0)
    row += Math.sin(direction).round
    column += Math.cos(direction).round
    if has_disc?(column, row)
      count_owned_adjacent(direction, column, row, count + 1)
    else
      count
    end
  end

end