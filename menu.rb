# menu
require_relative 'create_item_option'
require_relative 'list_all_books'
require_relative 'list_all_labels'
require_relative 'list_all_games'
require_relative 'list_music_album'
require_relative 'list_genre'
require_relative 'exit_option'

# display menu
class Menu
  def initialize(app)
    @app = app
    @options = [
      CreateItemOption,
      ListAllbooks,
      ListAllLabels,
      ListAllGames,
      ExitOption
    ]
  end

  def display
    puts 'Please select an option by entering a number:'
    @options.each_with_index { |option, index| puts "#{index + 1}. #{option.new(@app).name}" }
  end

  def handle_option(option)
    @options[option - 1].new(@app).execute
  end
end

# Run the main function if this file is executed
main if __FILE__ == $PROGRAM_NAME
