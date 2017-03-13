require_relative '../app/models/player'

describe 'Player' do

  before :all do
    @player = Player.new(1)
  end

  it 'should have a number' do
    expect(@player.number).not_to be_nil
  end

end
