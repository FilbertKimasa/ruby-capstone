# label class
class Label
  attr_accessor :title, :color, :items
  attr_reader :id

  def initialize(title, color)
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
  end

  def to_hash
    {
      'id' => @id,
      'title' => @title,
      'color' => @color,
      'items' => @items.map(&:to_hash)
    }
  end
end
