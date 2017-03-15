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

  def detect_four(direction, x, y)
    #check right
    #then check left w/ count from right
  end

  def count_owned_adjacent(direction, x, y, count=0)
    case
      when :right
        x += 1
      when :left
        x -= 1
      when :down
        y -= 1
      when :diagonal_315
        y -= 1
        x += 1
      when :diagonal_45
        x += 1
        y += 1
      when :diagonal_135
        x -= 1
        y += 1
      when :diagonal_225
        x -= 1
        y -= 1
    end

    if @discs.include? [x, y]
      count_owned_adjacent(direction, x, y, count + 1)
    else
      count
    end
  end

end