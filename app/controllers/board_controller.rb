class BoardController < ApplicationController
  def index
    @board = Board.instance
    @canvas_scale = 50
  end

  def reset
    Board.instance.reset
  end

  def drop_disc
    disc = Board.instance.drop_disc(params['column'].to_i)
    render json: Board.instance.last_disc
    Board.instance.swap_player unless disc.nil?
  end

  def get_discs
    render json: {'player1' => Board.instance.player_one.discs,
                  'player2' => Board.instance.player_two.discs}
  end

  def check_game_over
    state = Board.instance.check_game_over
    if state == :tie
      render json: {'tie' => 'true'}
    elsif !state
      render json: {}
    else
      render json: {'winner' => state.number}
    end
  end

end
