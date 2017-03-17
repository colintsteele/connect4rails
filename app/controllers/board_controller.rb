class BoardController < ApplicationController
  def index
    @board = Board.instance
    @canvas_scale = 50
  end

  def reset
    Board.instance.reset
  end

  def drop_disc
    @board = Board.instance
    return unless @board.drop_disc(params['column'].to_i)
    render json: { 'disc' => Disc.last, 'color' => @board.current_player.color, 'opponent' => @board.current_player.opponent.color }
    Board.instance.swap_player unless Disc.last.nil?
  end

  def get_discs
    # render json: {'player1' => Board.instance.player_one.discs,
    #               'player2' => Board.instance.player_two.discs}
    render json: {'p1_color' => Board.instance.player_one.color, 'p1_discs' => Disc.where(player_id: Board.instance.player_one.id), 'p2_color' => Board.instance.player_two.color, 'p2_discs' => Disc.where(player_id: Board.instance.player_two.id) }
  end

  def check_game_over
    state = Board.instance.check_game_over
    if state == :tie
      render json: {'tie' => 'true'}
    elsif !state
      render json: {}
    else
      render json: {'winner' => state.id}
    end
  end

end
