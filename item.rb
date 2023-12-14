# item.rb
require 'date'

class Item
  attr_writer :genre, :author, :source, :label
  attr_reader :published_date

  def initialize(published_date)
    @id = Random.rand(1...1000)
    @published_date = published_date
    @archived = false
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts "This item has been archived."
    else
      puts "This item cannot be archived at this time."
    end
  end

  private

  attr_accessor :archived
  attr_reader :id

  def can_be_archived?
    (Time.now.year - Date.parse(@published_date).year) > 10
  end
end
