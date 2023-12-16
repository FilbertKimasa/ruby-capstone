require 'json'

# file operations class
class FileOperations
  def initialize(app)
    @app = app
  end

  def save_data_to_files
    save_to_file('books.json', @app.books)
    save_label_to_file('labels.json', @app.labels)
    save_game_to_file('games.json', @app.games)
    save_music_to_file('music.json', @app.music_albums)
    save_genres_to_file('genres.json', @app.genres)
  end

  def load_data_from_files
    load_books
    load_labels
    load_games
    load_music_albums
    load_genres

  end

  def load_books
    load_from_file('books.json') do |data|
      @app.books = data.map do |book_data|
        Book.new(book_data['publish_date'], book_data['publisher'], book_data['cover_state'])
      end
    end
  end

  def load_music_albums
    load_from_file('music.json') do |data|
      @app.music_albums = data.map do |album|
        MusicAlbum.new(album['published_date'], album['on_spotify'])
      end
    end
  end

  def load_genres
    load_from_file('genres.json') do |data|
      @app.genres = data.map do |genre|
        Genre.new(genre['genre_name'])
      end
    end
  end

  def load_labels
    load_from_file('labels.json') do |data|
      @app.labels = data.map { |label_data| Label.new(label_data['title'], label_data['color']) }
    end
  end

  def load_games
    load_from_file('games.json') do |data|
      @app.games = data.map do |game_data|
        Game.new(game_data['published date'], game_data['multiplayer'], game_data['last played at'])
      end
    end
  end

  def save_to_file(file_name, data)
    existing_data = load_from_file(file_name) || [] # Load existing data or initialize with an empty array
    updated_data = existing_data + data.map do |book|
      {
        'id' => book.id,
        'publish_date' => book.published_date || '', # Handle nil case
        'publisher' => book.publisher,
        'cover_state' => book.cover_state
      }
    end

    File.open(file_name, 'w') do |file|
      file.puts(JSON.generate(updated_data))
    end
  end

  def save_label_to_file(file_name, data)
    existing_data = load_from_file(file_name) || [] # Load existing data or initialize with an empty array
    updated_data = existing_data + data.map do |label|
      {
        'title' => label.title,
        'color' => label.color
      }
    end

    File.open(file_name, 'w') do |file|
      file.puts(JSON.generate(updated_data))
    end
  end

  def save_game_to_file(file_name, data)
    existing_data = load_from_file(file_name) || [] # Load existing data or initialize with an empty array
    updated_data = existing_data + data.map do |game|
      {
        'published date' => game.published_date,
        'multiplayer' => game.multiplayer,
        'last played at' => game.last_played_at
      }
    end

    File.open(file_name, 'w') do |file|
      file.puts(JSON.generate(updated_data))
    end
  end

   def save_music_to_file(file_name, data)
    existing_data = load_from_file(file_name) || [] # Load existing data or initialize with an empty array
    updated_data = existing_data + data.map do |album|
      {
        'published_date' => album.published_date,
        'on_spotify' => album.on_spotify
      }
    end

    File.open(file_name, 'w') do |file|
      file.puts(JSON.generate(updated_data))
    end
  end

  def save_genres_to_file(file_name, data)
    existing_data = load_from_file(file_name) || [] # Load existing data or initialize with an empty array
    updated_data = existing_data + data.map do |genre|
      {
        'genre_name' => genre.name
      }
    end

    File.open(file_name, 'w') do |file|
      file.puts(JSON.generate(updated_data))
    end
  end

  def load_from_file(file_name, &block)
    return unless File.exist?(file_name)

    json_data = File.read(file_name)
    data = JSON.parse(json_data)
    block.call(data) if block_given?
  end

  def find_book_by_title(publisher)
    @app.books.find { |book| book.publisher == publisher }
  end
end
