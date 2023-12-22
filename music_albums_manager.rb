class MusicAlbumsManager
    def initialize(app)
        @app = app
        @music_albums = []  
        @genres = []  
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

    def find_or_create_genre(name)
    existing_genre = @genres.find { |g| g.name == name }
    return existing_genre if existing_genre

    new_genre = Genre.new(name)
    @genres << new_genre
    new_genre
  end
end