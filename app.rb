# app
require 'json'
require_relative 'item'
require_relative 'list_all_books'
require_relative 'book_label'
require_relative 'label'

class App
  attr_accessor :item

  def initialize
    @books = []
    @labels = []
  end

  def add_label(title, color)
    label = Label.new(title, color)
    @labels << label
  end

  def add_item
    puts 'select an option below'
    print 'Do you want to add a book (1)'
    print 'Do you want to add a music album(2)'
    print 'Do you want to add a movie(3)'
    print 'Do you want to add a game(4)'

    item_type = gets.chomp.to_i
    case item_type
    when 1
      add_book
      when 2
        list_all_books
      # when 3
      #   create_movie
      # when 4
      #   create_game
    else
      puts 'Invalid Option'
    end
  end

  def add_book
    print 'Label: '
    label_name = gets.chomp
    label = find_or_create_label(label_name)

    print 'Publish Date: '
    publish_date = gets.chomp

    print 'Publisher: '
    publisher = gets.chomp

    print 'Cover State: '
    cover_state = gets.chomp

    book = Book.new(publish_date, publisher, cover_state)
    book.label = label

    @books << book
    label.add_item(book)

    puts "Book '#{publisher}' added successfully!"
  end

  def list_all_books
    if @books.empty?
      puts 'No books found.'
    else
      puts 'List of all books:'
      @books.each do |item|
        if item.is_a?(Book)
          puts "Publisher: #{item.publisher}, Cover State: #{item.cover_state}"
        end
      end
    end
  end

  private

  def find_or_create_label(title)
    existing_label = @labels.find { |label| label.title == title }
    return existing_label if existing_label

    new_label = Label.new(title, 'default_color')
    @labels << new_label
    new_label
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
