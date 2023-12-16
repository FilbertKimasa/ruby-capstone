require_relative 'menu_option'

class ListMusicAlbum < MenuOption
  def execute
    @app.list_all_music_albums
  end

  def name
    'List all music albums'
  end
end
