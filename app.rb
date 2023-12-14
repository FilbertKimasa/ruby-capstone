# app.rb

require_relative 'music_album'
require_relative 'genre'

class App
  attr_accessor :music_albums, :genres

  def initialize
    @genres = []
    @music_albums = []
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts "No music albums available."
    else
      puts "List of all music albums:"
      @music_albums.each { |album| puts album.to_s }
    end
  end

  def list_all_genres
    if @genres.empty?
      puts "No genres available."
    else
      puts "List of all genres:"
      @genres.each { |genre| puts genre.name }
    end
  end

  def add_music_album(genre_name, published_date, on_spotify)
    genre = find_or_create_genre(genre_name)
    music_album = MusicAlbum.new(published_date, on_spotify)
    music_album.title = title
    music_album.artist = artist
    genre.add_item(music_album)
    @music_albums << music_album
    puts "Music album added: #{music_album.to_s}"
  end

  private

  def find_or_create_genre(name)
    existing_genre = @genres.find { |g| g.name == name }
    return existing_genre if existing_genre

    new_genre = Genre.new(name)
    @genres << new_genre
    new_genre
  end
end
