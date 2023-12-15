require_relative 'menu_option'

class ListAllbooks < MenuOption
  def execute
    @app.list_all_books
  end

  def name
    'List all books'
  end
end
