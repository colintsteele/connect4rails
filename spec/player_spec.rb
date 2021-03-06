require_relative '../app/models/board'
require_relative '../app/models/player'
require 'spec_helper'

describe 'Player' do

  before :all do
    @player = Player.new(color: 'red')
    @board = Board.instance
  end

  after :each do
    @board.reset
  end

  it 'should have a color' do
    expect(@player.color).not_to be_nil
  end

  it 'should keep track of its discs' do
    2.times do
      @board.drop_disc(0)
    end
    expect(@board.current_player.discs).not_to be_empty
  end
context 'counting adjacent slots' do

  it 'should count two horizontal' do
    player = @board.current_player
    @board.drop_disc(0)
    @board.drop_disc(0)
    @board.drop_disc(1)
    owned_right = player.count_owned_adjacent(360, 0, 6)
    expect(owned_right).to eq(1)
  end

  it 'should count diagonal up-right' do
    player = @board.current_player
    @board.drop_disc(0)
    @board.drop_disc(1)
    @board.drop_disc(1)
    owned_up_right = player.count_owned_adjacent(45, 0, 6)
    expect(owned_up_right).to eq(1)
  end

  it 'should find a connect 4 when present' do
    player = @board.current_player
    @board.drop_disc(0)
    @board.drop_disc(0)
    @board.drop_disc(1)
    @board.drop_disc(1)
    @board.drop_disc(2)
    @board.drop_disc(2)
    @board.drop_disc(3)
    @board.drop_disc(3)
    expect(player.detect_win(3, 6)).to be_truthy
  end

end



end
