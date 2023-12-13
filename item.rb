# item.rb

class Item
  attr_accessor :genre, :author, :source, :label

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
    (Time.now.year - @published_date.year) > 10
  end
end
