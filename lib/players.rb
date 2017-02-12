require_relative 'participant'

class Player < Participant
  def set_name
    name = nil
    loop do
      puts "What is your name?"
      name = gets.chomp
      break unless name.strip.empty?
      puts "Please enter your name."
    end
    @name = name
  end

  def stay
    clear_screen
    puts "#{name} stays at #{total}"
  end

  def hit_or_stay
    answer = nil
    loop do
      puts "(H)it or (S)tay?"
      answer = gets.chomp.downcase
      break if %w(s stay h hit).include?(answer)
      puts "Invalid choice. Please enter H or S"
    end
    answer
  end

  def turn(other_player, deck)
    loop do
      break if %w(s stay).include?(hit_or_stay)
      clear_screen
      hit!(deck)
      show_cards
      return busted(other_player) if bust?
      other_player.show_top_card
    end
    stay
  end
end

class Dealer < Participant
  def set_name
    @name = 'Dealer'
  end

  def show_top_card
    card = hand.first
    puts
    puts "The #{name} is showing a #{card}."
  end

  def busted(other_player)
    show_cards
    puts
    puts "#{name} busts! #{other_player.name} wins!"
  end

  def turn(other_player, deck)
    puts "It's now the Dealer's turn."
    until beat?(other_player) || total == Game::GAME_SCORE
      hit!(deck)
      return busted(other_player) if bust?
    end
    stay
  end
end
