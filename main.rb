require_relative 'app'
require_relative 'menu'
require_relative 'file_operations'

# app entry point
class Catalog
  def initialize
    @app = App.new
    @menu = Menu.new(@app)
    @file_operations = FileOperations.new(@app)
  end

  def start
    @file_operations.load_data_from_files

    display_welcome_message

    loop do
      @menu.display
      option = user_input
      break if @menu.handle_option(option) == :exit
    end

    exit_program
  end

  private

  def display_welcome_message
    puts 'Welcome to my catalog!'
    puts ' '
  end

  def user_input
    gets.chomp.to_i
  end

  def exit_program
    @file_operations.save_data_to_files
    puts 'Thank you for using this app! Goodbye!'
  end
end

Catalog.new.start
