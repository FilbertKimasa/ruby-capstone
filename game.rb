require_relative 'item'
require 'date'

class Game < Item
  attr_accessor :multiplayer, :last_played_at
  attr_reader :id

  def initialize(publish_date, multiplayer, last_played_at)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    # Override the parent method
    parent_can_be_archived = super

    # Add additional conditions for archiving in the child class
    parent_can_be_archived && (Date.today - last_played_at >= 365 * 2)
  end
end
