# item.rb

class Item
  attr_accessor :title, :description, :published_date, :archived, :comments

  def initialize(title, description, published_date)
    @title = title
    @description = description
    @published_date = published_date
    @archived = false
    @comments = []
  end

  def add_comment(comment)
    @comments << comment
  end

  def display_comments
    @comments.each { |comment| puts comment }
  end

  def can_be_archived?
    (Time.now.year - @published_date.year) > 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts "#{@title} has been archived."
    else
      puts "#{@title} cannot be archived at this time."
    end
  end
end
