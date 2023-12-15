# menu
require_relative 'create_item_option'
require_relative 'exit_option'

require_relative 'app'

def main
  app = App.new

  loop do
    puts "\nMenu:"
    puts '1. List all music albums'
    puts '2. List all genres'
    puts '3. Add a music album'
    puts '4. Exit'

    print 'Enter your choice (1-4): '
    choice = gets.chomp.to_i

    case choice
    when 1
      app.list_all_music_albums
    when 2
      app.list_all_genres
    when 3
      print 'Enter title: '
      title = gets.chomp
      print 'Enter genre: '
      genre_name = gets.chomp
      print 'Enter published date (YYYY-MM-DD): '
      published_date = gets.chomp
      print 'Is it on Spotify? (true/false): '
      on_spotify = gets.chomp.downcase == 'true'

      app.add_music_album(genre_name, title, published_date, on_spotify)
    when 4
      puts 'Exiting the program. Goodbye!'
      break
    else
      puts 'Invalid choice. Please enter a number between 1 and 4.'
    end
  end
end

# Run the main function if this file is executed
main if __FILE__ == $PROGRAM_NAME
