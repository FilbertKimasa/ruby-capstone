# item.rb
require 'date'

class Item
  attr_accessor :published_date
  attr_reader :genre, :author, :source, :label

  def initialize(published_date)
    @id = Random.rand(1...1000)
    @published_date = published_date
    @archived = false
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts 'This item has been archived.'
    else
      puts 'This item cannot be archived at this time.'
    end
  end

  def genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  def source=(source)
    @source = source
    source.items.push(self) unless source.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  private

  attr_accessor :archived
  attr_reader :id

  def can_be_archived?
    (Time.now.year - Date.parse(@published_date).year) > 10
  end
end
