# frozen_string_literal: true

require_relative 'card'

# A simple represenation of a deck of playing cards
class Deck
  attr_reader :storage
  private :storage

  include Enumerable

  def each
    storage.each do |card|
      yield card
    end
  end

  def initialize
    @storage = Card::SUITS.map do |suit|
      Card::RANKS.map { |rank| Card.new(rank, suit) }
    end.flatten
  end

  # swap front and back somewhere in the middle third.
  def cut
    count = storage.length
    random = Random.rand(count / 3)
    cut_point = (count / 3 + random)
    storage.replace(
      storage.slice(cut_point, count - cut_point) + storage.slice(0, cut_point)
    )
    # returning self allows you to chain additional methods than are not
    # normally chainable
    self
  end

  def draw
    storage.shift
  end

  def shuffle
    storage.shuffle!
    self
  end

  def deal(cards, *hands)
    cards.times do
      hands.each so | hand |
        hand << draw
    end
  end
end
