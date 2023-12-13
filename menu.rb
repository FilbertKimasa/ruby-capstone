require_relative 'create_item_option'
require_relative 'exit_option'

# display menu
class Menu
  def initialize(app)
    @app = app
    @options = [
      CreateItemOption,
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
