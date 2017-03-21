class Computer < Player
  has_many :discs

  def make_move
    column = (detect_opponent_win) ? detect_opponent_win : best_column
    Board.first.add_disc(column)
  end

  def detect_opponent_win
    opponent = Player.first
    7.times do |column|
      open_row = Board.first.find_open_row(column)
      return column if (open_row && opponent.detect_win(column, open_row))
    end
    nil
  end

  def best_column
    pi = Math::PI
    columns = {}
    opponent = Player.last
    (0..6).each do |column|
      max = 0
      [2*pi, pi/4, pi/2, 3*pi/4].each do |direction|
        row = Board.first.find_open_row(column)
        next if row.nil?
        side_one = opponent.count_owned_adjacent(direction, column, row)
        side_two = opponent.count_owned_adjacent(direction - pi, column, row)
        sum = side_one + side_two
        max = sum if sum > max
      end
      columns[column] = max
    end
    max = columns.key(columns.values.max)
    max.zero? ? rand(0..6) : max
  end

end
