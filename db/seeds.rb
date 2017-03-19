@board = Board.create
Player.create(color: 'red', board: @board)
Player.create(color: 'blue', board: @board)
@board.current_player = Player.first

4.times do
  @board.add_disc(6)
end

(2..5).each do |i|
  @board.add_disc(i)
end





