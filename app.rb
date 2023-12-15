# app
require 'json'
require_relative 'item'
require_relative 'music_album'
require_relative 'genre'

class App
  attr_accessor :item

  def initialize
    @item = []
    @genres = []
    @music_albums = []
    load_data
  end

  def add_book
    print 'Enter Genre: '
    genre = gets.chomp
    print 'Enter Author: '
    author = gets.chomp
    print 'Enter source: '
    source = gets.chomp
    print 'Enter label: '
    label = gets.chomp
    item = Item.new(genre)
    @item << item
    puts 'Item Created Successfully'
    puts ' '
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts 'No music albums available.'
    else
      puts 'List of all music albums:'
      @music_albums.each { |album| puts album.title }
    end
  end

  def list_all_genres
    if @genres.empty?
      puts 'No genres available.'
    else
      puts 'List of all genres:'
      @genres.each { |genre| puts genre.name }
    end
  end

  def add_music_album(genre_name, title, published_date, on_spotify)
    genre = find_or_create_genre(genre_name)
    music_album = MusicAlbum.new(published_date, title, on_spotify)
    music_album.title = title
    genre.add_item(music_album)
    @music_albums << music_album
    puts "Music album added: #{music_album.title}"
    save_data
  end

  private

  def find_or_create_genre(name)
    existing_genre = @genres.find { |g| g.name == name }
    return existing_genre if existing_genre

    new_genre = Genre.new(name)
    @genres << new_genre
    new_genre
  end

  def save_data
    music_albums_data = @music_albums.map do |album|
      {
        title: album.title,
        published_date: album.published_date,
        on_spotify: album.on_spotify,
        genre_name: album.genre.name
      }
    end

    genres_data = @genres.map do |genre|
      {
        name: genre.name,
        items: genre.items.map { |item| item.title }
      }
    end

    data = { music_albums: music_albums_data, genres: genres_data }
    File.open('music.json', 'w') { |file| file.write(data.to_json) }
  end

  def load_data
    if File.exist?('music.json')
      data = JSON.parse(File.read('music.json'))

      @music_albums = data['music_albums'].map do |album_data|
        MusicAlbum.new(album_data['published_date'], album_data['title'], album_data['on_spotify'])
      end

      @genres = data['genres'].map { |genre_data| Genre.new(genre_data['name']) }
    else
      @music_albums = []
      @genres = []
    end
  end
end
