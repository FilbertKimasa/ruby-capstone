# music_album
require_relative 'item'

class MusicAlbum < Item
  attr_reader :on_spotify
  attr_accessor :name

  def initialize(published_date, on_spotify)
    super(published_date)
    @on_spotify = on_spotify
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end