require_relative '../app/models/board'
require_relative '../app/models/player'

describe 'Connect 4 board' do

  before :all do
    @board = Board.instance
    @player = @board.player_one
  end

  after :each do
    @board.reset
  end

  context 'initial board state' do

    it 'should not be nil' do
      expect(@board).not_to be_nil
    end

    it 'should be able to traverse the grid' do
      count = 0
      @board.through_grid do
        count += 1
      end
      expect(count).to eq(@board.height * @board.width)
    end

    it 'should be an entirely empty grid' do
      p1_discs = @board.player_one.discs
      p2_discs = @board.player_two.discs
      expect(p1_discs).to be_empty
      expect(p2_discs).to be_empty
    end

  end

  context 'dropping discs' do

    it 'should be able to find the bottom row' do
      bottom_row = @board.find_bottom_row(0)
      expect(bottom_row).to eq(6)
    end

    it 'should be able to see what where player\'s discs are' do
      @board.drop_disc(0)
      expect(@board.grid(0, @board.height-1)).not_to be_nil
    end

    it 'should put a disc in the bottom row' do
      @board.drop_disc(0)
      expect(@board.grid(0, @board.height-1).class).to be_truthy
    end

    it 'should find the second-to-last row after one drop' do
      @board.drop_disc(0)
      expect(@board.find_bottom_row(0)).to eq(5)
    end

    it 'should not put a disc in a full column' do
      @board.height.times do
        @board.drop_disc(0)
      end
      expect(@board.drop_disc(0)).to be_nil
    end

    it 'should return the coordinates of the disc that was dropped' do
      coord = @board.drop_disc(0)
      expect(coord).not_to be_empty
    end

    it 'should record how many discs have been dropped' do

    end

  end

end

