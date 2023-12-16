# app.rb
require_relative 'item'
require_relative 'list_all_books'
require_relative 'book_label'
require_relative 'label'
require_relative 'game'
require_relative 'file_operations'
require_relative 'genre'
require_relative 'music_album'
require 'date'

class App
  attr_accessor :books, :labels, :games, :music_albums, :genres

  def initialize
    @books = []
    @labels = []
    @games = []
    @genres = []
    @music_albums = []
    @file_operations = FileOperations.new(self)
  end

  def add_label(title, color)
    label = Label.new(title, color)
    @labels << label
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

  def prompt_create_options
    puts 'Select an option below:'
    puts '1. Add a book'
    puts '2. Add a game'
    puts '3. Add a music album'
    puts '4. Add a movie'
  end

  # add book method
  def add_book
    label = label_prompt
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
    @books << book

    puts "Book #{publisher} added successfully!"
  end

  def label_prompt
    print 'Label title(Gift/new): '
    label_name = gets.chomp
    print 'Label color: '
    label_color = gets.chomp

    # Find or create label
    find_or_create_label(label_name, label_color)
  end

  def list_all_books
    if @books.empty?
      puts 'No books found.'
    else
      puts 'List of all books:'
      @books.each do |item|
        if item.is_a?(Book)
          puts "Publisher: #{item.publisher}, Cover State: #{item.cover_state}, Published date: #{item.published_date}"
        end
      end
    end
  end

  def prompt_label
    print 'Label title(Gift/new): '
    label_name = gets.chomp
    print 'Label color: '
    label_color = gets.chomp
    find_or_create_label(label_name, label_color)
  end

  def list_all_labels
    if @labels.empty?
      puts 'No labels found.'
    else
      puts 'List of all labels:'
      @labels.each do |item|
        puts "Label title: #{item.title}, Cover State: #{item.color}" if item.is_a?(Label)
      end
    end
  end

  def add_game
    print 'Is the game multiplayer? (1 for Yes, 2 for No): '
    multiplayer_option = gets.chomp.to_i
    multiplayer = (multiplayer_option == 1)

    print 'Published date (YYYY/MM/DD): '
    published_date = gets.chomp

    print 'Last play date (YYYY/MM/DD): '
    last_play_date = gets.chomp

    game = Game.new(published_date, multiplayer, last_play_date)
    @games << game
    puts 'Game added successfully!'
  end

  def list_all_games
    if @games.empty?
      puts 'No games found.'
    else
      puts 'List of all games:'
      @games.each do |item|
        puts "Multiplayer: #{item.multiplayer}, Last Played: #{item.last_played_at}" if item.is_a?(Game)
      end
    end
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts 'No music albums available.'
    else
      puts 'List of all music albums:'
      concatenated_info = @music_albums.map do |album|
        "Published Date: #{album.published_date}, On Spotify: #{album.on_spotify}"
      end.join("\n")

      puts concatenated_info
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

  def add_music_album
    print 'Enter genre: '
    genre_name = gets.chomp
    print 'Enter published date (YYYY-MM-DD): '
    published_date = gets.chomp
    print 'Is it on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    genre = find_or_create_genre(genre_name)
    music_album = MusicAlbum.new(published_date, on_spotify)
    genre.add_item(music_album)
    @music_albums << music_album
    puts 'Music album added'
  end

  private

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
