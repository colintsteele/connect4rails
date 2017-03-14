class WelcomeController < ApplicationController
  def index
    @board = Board.instance
    @canvas_scale = 50
  end

  def drop_disc
    #get column from params
    #drop_disc logic moves here
    #swap_player method call goes here
  end

end
