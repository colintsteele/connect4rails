class Player
  attr_reader :number, :discs

  def initialize(number)
    @discs = []
    @number = number
  end

  def add_disc(column, row)
    @discs << [column, row]
  end

end