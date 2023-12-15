require_relative 'item'
require 'date'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :published_date
  attr_reader :id

  def initialize(published_date, multiplayer, last_played_at)
    super(published_date)
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at.to_s)
    @published_date = published_date
  end

  def can_be_archived?
    parent_can_be_archived = super
    parent_can_be_archived && (Date.today - published_date).to_i > 3652
  end
end
