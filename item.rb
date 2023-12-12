# item.rb

class Item
  attr_writer :genre, :author, :source, :label

  def initialize(published_date, archived: false)
    @published_date = published_date
    @archived = archived
  end

  def can_be_archived?
    (Time.now.year - @published_date.year) > 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
    end
  end
end
