require_relative 'item'

class MusicAlbum < Item
    attr_accessor :on_spotfy
    
    def initialize(published_date, on_spotify)
        super(published_date)
        @on_spotify = on_spotify
    end
    
    private
    def can_be_archived?

    end
        
    
end