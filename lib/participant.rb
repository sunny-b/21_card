require_relative 'clear'

class Participant
  include Clearable

  attr_reader :name
  attr_accessor :hand, :score

  def initialize
    overall_reset
  end

  def beat?(other_player)
    total > other_player.total
  end

  def overall_reset
    @hand = []
    @score = 0
  end

  def reset_hand
    @hand = []
  end

  def increase_score
    @score += 1
  end

  def hit!(deck)
    @hand << deck.deal!
    puts "#{name} hits!"
  end

  def stay
    puts "#{name} stays."
  end

  def bust?
    total > Game::GAME_SCORE
  end

  def busted(other_player)
    puts
    puts "#{name} busts! #{other_player.name} wins!"
  end

  def show_cards
    puts
    puts "#{name}'s hand:"
    hand.each { |card| puts "- #{card}" }
    puts "Total: #{total}"
  end

  def total
    sum = hand.map(&:score).reduce(:+)

    correction_factor = hand.select { |card| card.score == 11 }.count
    correction_factor.times do
      sum -= 10 if sum > Game::GAME_SCORE
    end
    sum
  end
end
