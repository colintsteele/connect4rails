class Player < ActiveRecord::Base
  belongs_to :board
  has_many :discs

  def self.reset
    Disc.where(player_id: self.id)
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

    # case direction
    #   when 360
    #     column += 1
    #   when 315
    #     column += 1
    #     row += 1
    #   when 270 #consider a special condition for down, in which the current is always at the end
    #     row += 1
    #   when 225
    #     row +=1
    #     column -= 1
    #   when 180
    #     column -= 1
    #   when 135
    #     column -= 1
    #     row -= 1
    #   when 90
    #     row -=1
    #   when 45
    #     row -=1
    #     column +=1
    # end
    if has_disc?(column, row)
      count_owned_adjacent(direction, column, row, count + 1)
    else
      count
    end

  end

end