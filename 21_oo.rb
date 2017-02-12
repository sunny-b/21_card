Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

class Game
  include Clearable, Displayable

  GAME_SCORE = 21
  PLAY_TO = 5

  attr_reader :deck, :round, :player, :dealer

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @round = Round.new
  end

  def start
    clear_screen
    display_welcome_message
    set_names
    round.main_game_loop(self, player, dealer, deck)
    display_goodbye_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (Y/N)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Please enter either Y or N"
    end
    answer == 'y'
  end

  def someone_won?
    player.score == PLAY_TO || dealer.score == PLAY_TO
  end

  def reset_hands
    player.reset_hand
    dealer.reset_hand
  end

  def reset
    player.overall_reset
    dealer.overall_reset
  end

  def play_another_round
    puts "Enter 'Q' if you want to quit. Otherwise enter any key to play again."
    answer = gets.chomp.downcase
    die if answer == 'q'
  end

  def die
    display_goodbye_message
    exit
  end

  def increase_winner_score
    determine_winner&.increase_score
  end

  def determine_winner
    if player.bust?
      return dealer
    elsif dealer.bust?
      return player
    elsif player.beat?(dealer)
      return player
    elsif dealer.beat?(player)
      return dealer
    end
  end

  def set_names
    player.set_name
    dealer.set_name
  end

  def deal_cards
    puts "#{player.name} has been dealt in."

    deck.reset
    2.times do
      player.hand << deck.deal!
      dealer.hand << deck.deal!
    end
  end
end

Game.new.start
