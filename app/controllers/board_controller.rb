class BoardController < ApplicationController
  before_filter :set_board
  def index
  end

  def reset
    @board.reset
  end

  def drop_disc
    if @board.add_disc(params['column'].to_i)
      game_over = Board.first.check_game_over
      render json: [Disc.last, game_over]
    end
  end

  def discs
    render json: Disc.all
  end

  def check_game_over
    state = @board.check_game_over
    if state == :tie
      render json: {'tie' => 'true'}
    elsif !state
      render json: {}
    else
      render json: {'winner' => state.id}
    end
  end

  protected
  def set_board
    @board = Board.first
  end

end
