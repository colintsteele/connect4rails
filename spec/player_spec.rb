require_relative '../app/models/board'
require_relative '../app/models/player'

describe 'Player' do

  before :all do
    @player = Player.new(1)
    @board = Board.instance
  end

  it 'should have a number' do
    expect(@player.number).not_to be_nil
  end

  it 'should keep track of its discs' do
    2.times do
      @board.drop_disc(0)
    end
    expect(@board.current_player.discs).not_to be_empty
  end

end
