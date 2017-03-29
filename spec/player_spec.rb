require_relative '../app/models/board'
require_relative '../app/models/player'
require 'spec_helper'

describe 'Player' do

  before :all do
    @board = Board.first
    @player = Player.new(color: 'red', board: @board)
  end

  after :each do
    @board.reset
  end

  it 'should have a color' do
    expect(@player.color).not_to be_nil
  end

context 'counting adjacent slots' do

  it 'should count two horizontal' do
    player = Player.first
    @board.add_disc(0)
    @board.add_disc(0)
    @board.add_disc(1)
    owned_right = player.count_owned_adjacent(2*Math::PI, 0, 6)
    expect(owned_right).to eq(1)
  end

  it 'should count diagonal up-right' do
    player = Player.first
    @board.add_disc(0)
    @board.add_disc(1)
    @board.add_disc(1)
    owned_up_right = player.count_owned_adjacent(Math::PI/4, 0, 6)
    expect(owned_up_right).to eq(1)
  end

  it 'should find a connect 4 when present' do
    player = Player.first
    @board.add_disc(0)
    @board.add_disc(0)
    @board.add_disc(1)
    @board.add_disc(1)
    @board.add_disc(2)
    @board.add_disc(2)
    @board.add_disc(3)
    @board.add_disc(3)
    expect(player.detect_win(3, 6)).to be_truthy
  end

end



end
