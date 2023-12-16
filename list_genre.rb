require_relative 'menu_option'

class ListGenre < MenuOption
  def execute
    @app.list_all_genres
  end

  def name
    'List all genres'
  end
end
