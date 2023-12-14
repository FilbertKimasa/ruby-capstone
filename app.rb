require_relative 'item'
require_relative 'list_all_books'
require_relative 'book_label'
require_relative 'label'

# Core functionality class
class App
  attr_accessor :item

  def initialize
    @books = []
    @labels = []
  end

  def add_label(title, color)
    label = Label.new(title, color)
    @labels << label
  end

  def add_item
    puts 'select an option below'
    print 'Do you want to add a book (1)'
    print 'Do you want to add a music album(2)'
    print 'Do you want to add a movie(3)'
    print 'Do you want to add a game(4)'

    item_type = gets.chomp.to_i
    case item_type
    when 1
      add_book
      when 2
        list_all_books
      # when 3
      #   create_movie
      # when 4
      #   create_game
    else
      puts 'Invalid Option'
    end
  end

  def add_book
    print 'Label: '
    label_name = gets.chomp
    label = find_or_create_label(label_name)

    print 'Publish Date: '
    publish_date = gets.chomp

    print 'Publisher: '
    publisher = gets.chomp

    print 'Cover State: '
    cover_state = gets.chomp

    book = Book.new(publish_date, publisher, cover_state)
    book.label = label

    @books << book
    label.add_item(book)

    puts "Book '#{publisher}' added successfully!"
  end

  def list_all_books
    if @books.empty?
      puts 'No books found.'
    else
      puts 'List of all books:'
      @books.each do |item|
        if item.is_a?(Book)
          puts "Publisher: #{item.publisher}, Cover State: #{item.cover_state}"
        end
      end
    end
  end

  private

  def find_or_create_label(title)
    existing_label = @labels.find { |label| label.title == title }
    return existing_label if existing_label

    new_label = Label.new(title, 'default_color')
    @labels << new_label
    new_label
  end
end
