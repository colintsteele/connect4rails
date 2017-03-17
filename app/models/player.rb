require 'active_record'

class Player < ActiveRecord::Base
  has_many :discs

  def add_disc(column, row)
    Disc.create(column: column, row: row, player_id: self.id)
  end

  def has_disc?(column, row)
    true unless Disc.where(column: column, row: row, player_id: self.id).empty?
  end

  def reset
    Disc.where(player_id: self.id).delete_all
  end

  def detect_win(x, y, win = 3)
    [360, 315, 270, 225].each do |direction|
      side_one = count_owned_adjacent(direction, x, y)
      side_two = count_owned_adjacent(direction - 180, x, y)
      return true if side_one + side_two >= win
    end
    nil
  end

  def count_owned_adjacent(direction, column, row, count=0)
    case direction
      when 360
        column += 1
      when 315
        column += 1
        row += 1
      when 270 #consider a special condition for down, in which the current is always at the end
        row += 1
      when 225
        row +=1
        column -= 1
      when 180
        column -= 1
      when 135
        column -= 1
        row -= 1
      when 90
        row -=1
      when 45
        row -=1
        column +=1
    end
    if has_disc?(column, row)
      count_owned_adjacent(direction, column, row, count + 1)
    else
      count
    end

  end

  def opponent
    if self.id == 1
      Player.last
    else
      Player.first
    end
  end

end