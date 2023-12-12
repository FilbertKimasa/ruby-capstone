# main.rb
require_relative 'item'

class ConsoleApp
  def initialize
    @items = []
  end

  def start
    loop do
      display_menu
      choice = gets.chomp.to_i
      case choice
      when 1
        create_item
      when 2
        display_items
      when 3
        archive_item
      when 4
        exit_app
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  private

  def display_menu
    puts "1. Create Item"
    puts "2. Display Items"
    puts "3. Archive Item"
    puts "4. Exit"
    print "Choose an option: "
  end

  def create_item
    print "Enter title: "
    title = gets.chomp
    print "Enter description: "
    description = gets.chomp
    print "Enter published year: "
    published_year = gets.chomp.to_i

    item = Item.new(title, description, Time.new(published_year))
    @items << item
    puts "Item created successfully."
  end

  def display_items
    puts "Items:"
    @items.each do |item|
      puts "#{item.title} - #{item.description} (Published: #{item.published_date.year})"
    end
  end

  def archive_item
    display_items
    print "Enter the title of the item to archive: "
    item_title = gets.chomp

    item = @items.find { |i| i.title == item_title }
    if item
      item.move_to_archive
    else
      puts "Item not found."
    end
  end

  def exit_app
    puts "Exiting the app. Goodbye!"
    exit
  end
end

# Run the console app
app = ConsoleApp.new
app.start
