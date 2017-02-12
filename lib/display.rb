module Displayable
  def display_welcome_message
    puts "Welcome to 21!"
    puts "First one to win #{Game::PLAY_TO} rounds wins the game!"
    puts "You will be playing against the dealer."
  end

  def display_result
    player.show_cards
    dealer.show_cards
    puts
    display_winner
  end

  def display_winner
    if determine_winner
      puts "#{determine_winner.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "--------------"
    puts "#{player.name}: #{player.score}"
    puts "#{dealer.name}: #{dealer.score}"
    puts "--------------"
  end

  def display_initial_cards
    player.show_cards
    dealer.show_top_card
  end

  def display_goodbye_message
    puts "Thanks for playing! Good bye!"
  end

  def display_game_winner
    winner = (player.score == Game::PLAY_TO ? player : dealer)
    puts "#{winner.name} was the first to #{Game::PLAY_TO} points."\
         " #{winner.name} wins!"
  end
end
