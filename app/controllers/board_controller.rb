class BoardController < ApplicationController

  def index
    @board = Board.first
    #@canvas_scale = 50
    # @player1 = player.first
    # @player2 = player.last
    # @current_player = @player1
  end

  def reset
    @board.reset
  end

  def drop_disc
    render json: disc if disc = @current_player.drop_disc(params['column'].to_i)
  end

  def discs
    render json: disc.all
  end

  # def drop_disc
  #   @board = board.instance
  #   return unless @board.drop_disc(params['column'].to_i)
  #   render json: { 'disc' => disc.last, 'color' => @board.current_player.color, 'opponent' => @board.current_player.opponent.color }
  #   Board.instance.swap_player unless Disc.last.nil?
  # end

  def get_discs
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
