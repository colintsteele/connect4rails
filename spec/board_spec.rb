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

    it 'should be an entirely empty grid' do
      expect(Disc.all).to be_empty
    end

  end

  context 'dropping discs' do

    it 'should be able to find the bottom row' do
      bottom_row = @board.find_bottom_row(0)
      expect(bottom_row).to eq(6)
    end

    it 'should be able to see what where player\'s discs are' do
      @board.drop_disc(0)
      expect(@board.slot_owner(0, @board.height-1)).not_to be_nil
    end

    it 'should track most recent moves' do
      @board.drop_disc(0)
      expect(@board.last_disc).not_to be_nil
    end

    it 'should put a disc in the bottom row' do
      @board.drop_disc(0)
      expect(@board.slot_owner(0, @board.height-1).class).to be_truthy
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

    it 'should record how many discs have been dropped' do
      @board.drop_disc(0)
      expect(@board.count).not_to eq(0)
    end

    it 'should declare a players win' do
      @board.drop_disc(0)
      @board.drop_disc(0)
      @board.drop_disc(1)
      @board.drop_disc(1)
      @board.drop_disc(2)
      @board.drop_disc(2)
      @board.drop_disc(3)
      @board.drop_disc(3)
      expect(@board.check_game_over).not_to eq(:tie)
      expect(@board.check_game_over).not_to be_falsey
    end

    it 'should declare a tie after all tiles are full' do

    end

  end

end

