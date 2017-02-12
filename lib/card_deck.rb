class Deck
  SUITS = ['Hearts', 'Clubs', 'Diamonds', 'Spades'].freeze
  FACES = ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King'].freeze

  def initialize
    reset
  end

  def deal!
    Card.new(@cards.pop)
  end

  def reset
    @cards = FACES.product(SUITS)
    @cards.shuffle!
  end
end

class Card
  def initialize(card_array)
    @face = card_array.first
    @suit = card_array.last
  end

  def to_s
    "#{@face} of #{@suit}"
  end

  def score
    return @face if @face.to_s.to_i == @face
    @face[0] == 'A' ? 11 : 10
  end
end
