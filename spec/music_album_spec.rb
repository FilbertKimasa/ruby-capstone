# music_album_spec.rb

require_relative '../music_album'

RSpec.describe MusicAlbum do
  describe '#initialize' do
    it 'sets the published date and on Spotify' do
      album = MusicAlbum.new('2023-01-01', true)
      expect(album.instance_variable_get(:@published_date)).to eq('2023-01-01')
      expect(album.on_spotify).to eq(true)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true when on Spotify and superclass allows archiving' do
      album = MusicAlbum.new('2010-01-01', true)
      expect(album.send(:can_be_archived?)).to be(true)
    end

    it 'returns false when not on Spotify' do
      album = MusicAlbum.new('2010-01-01', false)
      expect(album.send(:can_be_archived?)).to be(false)
    end
  end
end
