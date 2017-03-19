class Computer < Player
  has_many :discs

  def make_move
    column = (detect_opponent_win) ? detect_opponent_win : rand(0..6)
    Board.first.add_disc(column)
  end

  def detect_opponent_win
    opponent = Player.first
    7.times do |column|
      row = Board.first.find_open_row(column)
      return column if (opponent.detect_win(column, row))
    end
    nil
  end

end
