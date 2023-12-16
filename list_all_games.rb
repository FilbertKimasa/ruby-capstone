require_relative 'menu_option'

class ListAllGames < MenuOption
  def execute
    @app.list_all_games
  end

  def name
    'List all games'
  end
end
