require 'json'

# file operations class
class FileOperations
  def initialize(app)
    @app = app
  end

  def save_data_to_files
    save_to_file('books.json', @app.books)
  end

  def load_data_from_files
    load_books
  end

  def load_books
    load_from_file('books.json') do |data|
      @app.books = data.map { |book_data| Book.new(book_data['publish_date'], book_data['publisher'], book_data['cover_state']) }
    end
  end

  def save_to_file(file_name, data)
    File.open(file_name, 'w') do |file|
      data = data.map do |book|
        {
          'id' => book.id,
          'publish_date' => book.published_date || '', # Handle nil case
          'publisher' => book.publisher,
          'cover_state' => book.cover_state
        }
      end
      file.write(JSON.generate(data))
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