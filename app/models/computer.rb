class Computer < Player
  has_many :discs

  def make_move
    column = (detect_opponent_win) ? detect_opponent_win : rand(0..6)
    Board.instance.drop_disc(column)
  end

  def detect_opponent_win
    opponent = Player.first
    7.times do |column|
      row = Board.instance.find_bottom_row(column)
      return column if (opponent.detect_win(column, row, win = 3))
    end
    nil
  end


end