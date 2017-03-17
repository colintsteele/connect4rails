require 'spec_helper'

describe 'Computer Player' do

  before :all do
    @board = Board.instance
  end

  before :each do
    @board.reset
  end

  it 'should be able to save to the database' do
    Computer.create(color: 'grey')
    expect(Player.where(color: 'grey')).not_to be_nil
  end

  it 'should be able to make moves itself' do

  end

  it 'should be able to block the opponent from winning' do

  end

end