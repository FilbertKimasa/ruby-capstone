# app
require_relative 'item'
require_relative 'music_album'
require_relative 'genre'

class App
  attr_accessor :item

  def initialize
    @item = []
    @genres = []
    @music_albums = []
  end

  def add_book
    print 'Enter Genre: '
    genre = gets.chomp
    print 'Enter Author: '
    author = gets.chomp
    print 'Enter source: '
    source = gets.chomp
    print 'Enter label: '
    label= gets.chomp
    item = Item.new(genre)
    @item << item
    puts 'Item Created Successfully'
    puts ' '
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts "No music albums available."
    else
      puts "List of all music albums:"
      @music_albums.each { |album| puts album.title }
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

  def add_music_album(genre_name,title, published_date, on_spotify)
    genre = find_or_create_genre(genre_name)
    music_album = MusicAlbum.new(published_date, title, on_spotify)
    music_album.title = title
    genre.add_item(music_album)
    @music_albums << music_album
    puts "Music album added: #{music_album.title}"
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
