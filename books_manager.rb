class BooksManager
    def initialize(app)
        @app = app
        @books = []
        @labels = []
    end

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

    private

  def find_or_create_label(title, color)
    existing_label = @labels.find { |label| label.title == title || label.color == color }
    return existing_label if existing_label

    new_label = Label.new(title, color)
    @labels << new_label
    new_label
  end
  
end