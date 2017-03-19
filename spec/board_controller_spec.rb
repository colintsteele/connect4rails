require 'spec_helper'

describe BoardController, type: :controller do

  context 'GET drop_disc2' do

    it 'should be able to reset' do
      board = Board.new()
      get :drop_disc2, column: 2
      @board.reset
    end

  end
  it 'should have two players' do
    expect(@board.player1).not_to be_nil
    expect(@board.player2).not_to be_nil
  end



end