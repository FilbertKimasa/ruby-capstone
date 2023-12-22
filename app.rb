# app.rb
require_relative 'item'
require_relative 'list_all_books'
require_relative 'book_label'
require_relative 'label'
require_relative 'game'
require_relative 'file_operations'
require_relative 'genre'
require_relative 'music_album'
require_relative 'books_manager'
require_relative 'games_manager'
require_relative 'music_albums_manager'

require 'date'

class App
  attr_accessor :books, :labels, :games, :music_albums, :genres

  def initialize

    @books = []
    @labels = []
    @games = []
    @genres = []
    @music_albums = []
    @books_manager = BooksManager.new(self)
    @games_manager = GamesManager.new(self)
    @music_albums_manager = MusicAlbumsManager.new(self)
    
    @file_operations = FileOperations.new(self)
  end


  def add_item_options
    puts 'Select an option below:'
    puts '1. Add a book'
    puts '2. Add a game'
    puts '3. Add a music album'
  end

  def add_item
    add_item_options
    item_type = gets.chomp.to_i
    case item_type
    when 1
      add_book
    when 2
      add_game
    when 3
      add_music_album
    else
      puts 'Invalid Option'
    end
  end

   def add_book
    @books_manager.add_book
  end

  def list_all_books
    @books_manager.list_all_books
  end

  def add_game
    @games_manager.add_game
  end

  def list_all_games
    @games_manager.list_all_games
  end

  def add_music_album
    @music_albums_manager.add_music_album
  end

  def list_all_music_albums
    @music_albums_manager.list_all_music_albums
  end

  def list_all_genres
    @music_albums_manager.list_all_genres
  end

  def list_all_labels
    @books_manager.list_all_labels
    
  end

end
