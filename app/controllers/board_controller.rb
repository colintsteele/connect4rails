class BoardController < ApplicationController
  def index
    @board = Board.instance
    @canvas_scale = 50;
  end

  def reset
    Board.instance.reset
  end

  def drop_disc
    Board.instance.drop_disc(params['column'].to_i)
  end

  def get_discs
    render json: {'player1' => Board.instance.player_one.discs, 'player2' => Board.instance.player_two.discs}
  end

end
