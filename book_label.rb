class Book < Item
  attr_accessor :publisher, :cover_state
  attr_reader :id

  def initialize(publish_date, publisher, cover_state)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  private

  def can_be_archived?
    # Override the parent method
    parent_can_be_archived = super

    # Add additional conditions for archiving in the child class
    parent_can_be_archived || cover_state == "bad"
  end
end
