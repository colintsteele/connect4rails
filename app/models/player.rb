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

end