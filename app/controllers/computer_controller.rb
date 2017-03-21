class ComputerController < ApplicationController

  def make_move
    if Player.first == Disc.last.player && Computer.new.make_move
      game_over = Board.first.check_game_over
      render json: [Disc.last, game_over]
    else
      render json: nil
    end
  end
end