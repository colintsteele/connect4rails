class ComputerController < ApplicationController

  def make_move
    if Computer.new.make_move
      game_over = Board.first.check_game_over
      render json: [Disc.last, game_over]
    end
  end
end