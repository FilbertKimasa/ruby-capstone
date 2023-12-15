require_relative '../game'
require_relative '../item'
require 'date'

describe Game do
  before :each do
    @game = Game.new('2012-10-05', true, '2021-08-11')
  end

  describe '#new' do
    it 'returns instance of the Game class' do
      expect(@game).to be_an_instance_of(Game)
    end
  end

  describe '#publish_date' do
    it 'return the date which game published at' do
      expect(@game.published_date.to_s).to eq('2012-10-05') # Adjust the format as needed
    end
  end

  describe '#mulitplayer' do
    it 'returning true if the game is multiplayer' do
      expect(@game.multiplayer).to be_truthy
    end
  end

  describe '#last_played_at' do
    it 'return the date which game last_played_at' do
      expect(@game.last_played_at.to_s).to eq('2021-08-11')
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if it is more than 10 years passed since publishing, otherwise false' do
      expect(@game.can_be_archived?).to be_truthy
      game = Game.new('2021-09-02', true, '2021-12-20')
      expect(game.can_be_archived?).to be_falsy
    end
  end
end