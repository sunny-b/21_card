require_relative 'clear'

class Round
  include Clearable

  def dealing_cards(game, player, dealer, deck)
    game.deal_cards
    game.display_initial_cards
    player.turn(dealer, deck)
    return if player.bust?
    dealer.turn(player, deck)
    return if dealer.bust?
    game.display_result
  end

  def scoring(game, player, dealer, deck)
    loop do
      dealing_cards(game, player, dealer, deck)
      game.increase_winner_score
      game.display_score
      return if game.someone_won?
      game.play_another_round
      clear_screen
      game.reset_hands
    end
  end

  def main_game_loop(game, player, dealer, deck)
    loop do
      scoring(game, player, dealer, deck)
      game.display_game_winner
      return unless game.play_again?
      clear_screen
      game.reset
    end
  end
end
