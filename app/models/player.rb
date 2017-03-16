class Player
  attr_reader :number, :discs, :color

  def initialize(number, color)
    @discs = []
    @number = number
    @color = color
  end

  def add_disc(column, row)
    @discs << [column, row]
  end

  def reset
    @discs =[]
  end

  def detect_win(x, y)
    [360, 315, 270, 225].each do |direction|
      side_one = count_owned_adjacent(direction, x, y)
      side_two = count_owned_adjacent(direction - 180, x, y)
      return true if side_one + side_two >= 3
    end
    nil
  end

  def count_owned_adjacent(direction, x, y, count=0)
    case direction
      when 360
        x += 1
      when 315
        x += 1
        y += 1
      when 270 #consider a special condition for down, in which the current is always at the end
        y += 1
      when 225
        y +=1
        x -= 1
      when 180
        x -= 1
      when 135
        x -= 1
        y -= 1
      when 90
        y -=1
      when 45
        y -=1
        x +=1
    end
    if @discs.include? [x, y]
      count_owned_adjacent(direction, x, y, count + 1)
    else
      count
    end

  end

  def opponent
    if @number == 1
      2
    else
      1
    end
  end

end