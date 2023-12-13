require_relative 'item'

# Core functionality class
class App
  attr_accessor :item

  def initialize
    @item = []
  end

  def add_book
    print 'Enter Genre: '
    genre = gets.chomp
    print 'Enter Author: '
    author = gets.chomp
    print 'Enter source: '
    source = gets.chomp
    print 'Enter label: '
    label= gets.chomp
    item = Item.new(genre)
    @item << item
    puts 'Item Created Successfully'
    puts ' '
  end
end
