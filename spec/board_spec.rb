require_relative '../app/models/board'

describe 'initial board state' do

  before :all do
    @board = Board.instance
  end

  it 'should not be nil' do
    expect(@board).not_to be_nil
  end

  it 'should have a 7 x 7 grid' do
    expect(@board.grid.size).to equal(7)
    expect(@board.grid.first.size).to equal(7)
  end

end
