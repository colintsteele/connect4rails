require_relative '../app/models/board'

describe 'initial board state' do

  before :all do
    @board = Board.instance
  end

  it 'should not be nil' do
    expect(@board).not_to be_nil
  end

  it 'should have a 7 x 7 grid' do
    expect(@board.grid.size).to eq(7)
    expect(@board.grid.first.size).to eq(7)
  end

  it 'should be able to traverse the grid' do
    count = 0
    @board.through_grid do
      count += 1
    end
    expect(count).to eq(49)
  end

  it 'should be an entirely empty grid' do
    not_nil = false
    @board.through_grid do |c, r|
      not_nil = true unless @board.grid[c][r].nil?
    end
    expect(not_nil).to be_falsey
  end

end

describe 'dropping discs' do

  before :all do
    @board = Board.instance
  end

end