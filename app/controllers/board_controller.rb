class BoardController < ApplicationController
  def index
    @board = Board.instance
    @canvas_scale = 50;
  end

  def drop_disc
    Board.instance.drop_disc(params['column'].to_i)
  end

end
