require_relative 'item'
require_relative 'list_all_books'
require_relative 'book_label'
require_relative 'label'
require_relative 'file_operations'
require 'date'

# Core functionality class
class App
  attr_accessor :item, :books, :labels

  def initialize
    @books = []
    @labels = []
    @file_operations = FileOperations.new(@app)
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
    when 3
      list_all_labels
      # when 4
      #   create_game
    else
      puts 'Invalid Option'
    end
  end

  def add_book
    label_prompt

    # Find or create label
    label = find_or_create_label(label_name, label_color)

    begin
      print 'Publish Date (YYYY/MM/DD) :'
      publish_date_input = gets.chomp
      publish_date = Date.parse(publish_date_input)
    rescue ArgumentError
      puts "Invalid date format. Please enter the date in the format YYYY/MM/DD."
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

    puts 'Book '#{publisher}' added successfully!'
  end

  def label_prompt
     print 'Label title(Gift/new): '
    label_name = gets.chomp
    print 'Label color: '
    label_color = gets.chomp
  end

  def list_all_books
    if @books.empty?
      puts 'No books found.'
    else
      puts 'List of all books:'
      @books.each do |item|
        puts "Publisher: #{item.publisher}, Cover State: #{item.cover_state}" if item.is_a?(Book)
      end
    end
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

  # Public methods for saving and loading data
  def save_data_to_files
    @file_operations.save_data_to_files
  end

  def load_data_from_files
    @file_operations.load_data_from_files
  end

  private

  def find_or_create_label(title, color)
    existing_label = @labels.find { |label| label.title == title || label.color == color }
    return existing_label if existing_label

    new_label = Label.new(title, color)
    @labels << new_label
    new_label
  end
end
