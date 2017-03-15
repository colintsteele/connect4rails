require_relative '../app/models/board'
require_relative '../app/models/player'
require 'spec_helper'

describe 'Player' do

  before :all do
    @player = Player.new(1, 'red')
    @board = Board.instance
  end

  it 'should have a number' do
    expect(@player.number).not_to be_nil
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

  it 'should count adjacent slots' do
    2.times do |i|
      @board.drop_disc(i, 1)
    end
    owned_right = @board.player_one.count_owned_adjacent(:right, 0, 6)
    expect(owned_right).to eq(2)
  end


end
