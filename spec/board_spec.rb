require_relative '../app/models/board'

describe 'initial board state' do

  before :all do
    @board = Board.instance
  end

  it 'should not be nil' do
    expect(@board).not_to be_nil
  end

  it 'should have a `height` x `width` grid' do
    expect(@board.grid.size).to eq(@board.width)
    expect(@board.grid.first.size).to eq(@board.height)
  end

  it 'should be able to traverse the grid' do
    count = 0
    @board.through_grid do
      count += 1
    end
    expect(count).to eq(@board.height * @board.width)
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

  after :each do
    @board.reset
  end

  it 'should be able to find the bottom row' do
    bottom_row = @board.find_bottom_row(0)
    expect(bottom_row).to eq(6)
  end

  it 'should put a disc in the bottom row' do
    player = 1
    column = 0
    @board.drop_disc(column, player)
    expect(@board.grid[column][@board.height-1]).to eq(1)
  end

  it 'should find the second-to-last row after one drop' do
    @board.drop_disc(0, 1)
    expect(@board.find_bottom_row(0)).to eq(5)
  end

  it 'should not put a disc in a full column' do
    @board.height.times do
      @board.drop_disc(0, 1)
    end
    expect(@board.drop_disc(0, 1)).to be_nil
  end



end