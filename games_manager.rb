class GamesManager
    def initialize(app)
        @app = app
        @games = []
    end

     def add_game
    print 'Is the game multiplayer? (1 for Yes, 2 for No): '
    multiplayer_option = gets.chomp.to_i
    multiplayer = (multiplayer_option == 1)

    print 'Published date (YYYY/MM/DD): '
    published_date = gets.chomp

    print 'Last play date (YYYY/MM/DD): '
    last_play_date = gets.chomp

    game = Game.new(published_date, multiplayer, last_play_date)
    @games << game
    puts 'Game added successfully!'
  end

  def list_all_games
    if @games.empty?
      puts 'No games found.'
    else
      puts 'List of all games:'
      @games.each do |item|
        puts "Multiplayer: #{item.multiplayer}, Last Played: #{item.last_played_at}" if item.is_a?(Game)
      end
    end
  end

end