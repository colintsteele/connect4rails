class WelcomeController < ApplicationController
  def index
    @board = Board.instance
  end

  def mytest
    print 'success'
  end

end
