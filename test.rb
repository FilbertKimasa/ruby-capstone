# app.rb
require_relative 'file_operations'
require_relative 'item'
require_relative 'label'
require_relative 'book'
require_relative 'game'
require_relative 'music_album'
require_relative 'genre'
require 'date'

class App
  attr_accessor :books, :labels, :games, :music_albums, :genres

  def initialize
    @books = []
    @labels = []
    @games = []
    @genres = []
    @music_albums = []
  end

  def run
    loop do
      show_menu
      choice = gets.chomp.to_i

      case choice
      when 1
        BooksManager.new(self).add_book
      when 2
        GamesManager.new(self).add_game
      when 3
        MusicAlbumsManager.new(self).add_music_album
      when 4
        LabelsManager.new(self).add_label
      when 5
        GenresManager.new(self).list_all_genres
      when 6
        break
      else
        puts 'Invalid option. Please try again.'
      end
    end
  end

  private

  def show_menu
    puts 'Select an option below:'
    puts '1. Add a Book'
    puts '2. Add a Game'
    puts '3. Add a Music Album'
    puts '4. Add a Label'
    puts '5. List all Genres'
    puts '6. Exit'
  end

  def find_or_create_label(title, color)
    existing_label = @labels.find { |label| label.title == title || label.color == color }
    return existing_label if existing_label

    new_label = Label.new(title, color)
    @labels << new_label
    new_label
  end

  def find_or_create_genre(name)
    existing_genre = @genres.find { |g| g.name == name }
    return existing_genre if existing_genre

    new_genre = Genre.new(name)
    @genres << new_genre
    new_genre
  end
end

# The rest of your classes (BooksManager, GamesManager, MusicAlbumsManager, LabelsManager, GenresManager) can remain the same as provided in the previous response.

class BooksManager
  def initialize(app)
    @app = app
  end

  def add_book
    puts 'Adding a Book:'
    label = LabelsManager.new(@app).prompt_label

    begin
      print 'Publish Date (YYYY/MM/DD): '
      publish_date_input = gets.chomp
      publish_date = Date.parse(publish_date_input)
    rescue ArgumentError
      puts 'Invalid date format. Please enter the date in the format YYYY/MM/DD.'
      return
    end

    print 'Publisher: '
    publisher = gets.chomp
    print 'Cover State: '
    cover_state = gets.chomp

    book = Book.new(publish_date, publisher, cover_state)
    book.label = label

    label.add_item(book)
    @app.books << book

    puts "Book #{publisher} added successfully!"
  end
end

class GamesManager
  def initialize(app)
    @app = app
  end

  def add_game
    puts 'Adding a Game:'
    print 'Is the game multiplayer? (1 for Yes, 2 for No): '
    multiplayer_option = gets.chomp.to_i
    multiplayer = (multiplayer_option == 1)

    print 'Published date (YYYY/MM/DD): '
    published_date = gets.chomp

    print 'Last play date (YYYY/MM/DD): '
    last_play_date = gets.chomp

    game = Game.new(published_date, multiplayer, last_play_date)
    @app.games << game
    puts 'Game added successfully!'
  end
end

class MusicAlbumsManager
  def initialize(app)
    @app = app
  end

  def add_music_album
    puts 'Adding a Music Album:'
    print 'Enter genre: '
    genre_name = gets.chomp
    print 'Enter published date (YYYY-MM-DD): '
    published_date = gets.chomp
    print 'Is it on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    genre = GenresManager.new(@app).find_or_create_genre(genre_name)
    music_album = MusicAlbum.new(published_date, on_spotify)
    genre.add_item(music_album)
    @app.music_albums << music_album
    puts 'Music album added'
  end
end

class LabelsManager
  def initialize(app)
    @app = app
  end

  def add_label
    puts 'Adding a Label:'
    print 'Label title(Gift/new): '
    label_name = gets.chomp
    print 'Label color: '
    label_color = gets.chomp

    label = @app.find_or_create_label(label_name, label_color)
    puts "Label #{label.title} added successfully!"
    label
  end
end

class GenresManager
  def initialize(app)
    @app = app
  end

  def list_all_genres
    if @app.genres.empty?
      puts 'No genres available.'
    else
      puts 'List of all genres:'
      @app.genres.each { |genre| puts genre.name }
    end
  end

  def find_or_create_genre(name)
    existing_genre = @app.genres.find { |g| g.name == name }
    return existing_genre if existing_genre

    new_genre = Genre.new(name)
    @app.genres << new_genre
    new_genre
  end
end