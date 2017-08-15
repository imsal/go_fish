#!/usr/bin/env ruby

class Game
  attr_accessor :deck
  attr_accessor :which_players_turn

  $players = ['Player 1', 'Player 2', 'Player 3', 'Player 4']

  def initialize
    @deck = create_deck

    @player_1_deck = []
    @player_2_deck = []
    @player_3_deck = []
    @player_4_deck = []

    @player_1_points = 0
    @player_2_points = 0
    @player_3_points = 0
    @player_4_points = 0

    deal_initial_cards

    @player_turn_index = 0

    display_which_players_turn_it_is
  end

  def create_deck

    numbers = (2..10).to_a
    numbers.push('Jack', 'Queen', 'King', 'Ace')
    suites = ['Hearts', 'Spades', 'Clubs', 'Diamonds']

    deck = []

    numbers.each do |num|
      suites.each do |suite|
        card_hash = { card_number: "#{num}", suite: "#{suite}", full_text: "#{num} of #{suite}" }
        deck.push(card_hash)
      end
    end

    return deck.shuffle!

  end

  def deal_initial_cards
    5.times do
      $players.each do |player|
        deal_one_card(player)
      end
    end
  end

  def deal_one_card(player)
    case player
    when 'Player 1'
      @player_1_deck.push(@deck.shift)
    when 'Player 2'
      @player_2_deck.push(@deck.shift)
    when 'Player 3'
      @player_3_deck.push(@deck.shift)
    when 'Player 4'
      @player_4_deck.push(@deck.shift)
    end
  end

  def return_player_deck(player)
    case player
    when 'Player 1'
      @player_1_deck
    when 'Player 2'
      @player_2_deck
    when 'Player 3'
      @player_3_deck
    when 'Player 4'
      @player_4_deck
    end
  end


  def display_player_cards(player)
    player_deck = return_player_deck(player)
    player_deck_display = []

    player_deck.each do |hash|
      hash.each do |key, value|
        if key == :full_text
            player_deck_display.push(value)
        end
      end
    end

    return player_deck_display.join(', ')
  end

  def display_board
    puts "Cards left in stock: #{@deck.count}"

    puts "Player 1: #{display_player_cards('Player 1')}"
    puts "Player 2: #{display_player_cards('Player 2')}"
    puts "Player 3: #{display_player_cards('Player 3')}"
    puts "Player 4: #{display_player_cards('Player 4')}"

    puts "It's #{@which_players_turn}'s Turn. Time to go fishing!"
  end



  def display_which_players_turn_it_is
    @which_players_turn = $players[@player_turn_index]
  end

  def increase_player_index
    @player_turn_index +=1

    if @player_turn_index > 3
      @player_turn_index = 0
    end
  end

  def do_you_have_any_of_type_card
    fishing_player=@which_players_turn

    loop do

    # this loop requires the user to select another player to fish from
    loop do
      puts "Enter a player (E.G. player 3)"
      $player_to_fish_from = $stdin.gets.chomp
      $player_to_fish_from.capitalize!

      unless $player_to_fish_from == 'Player 1' || $player_to_fish_from == 'Player 2' || $player_to_fish_from == 'Player 3' || $player_to_fish_from == 'Player 4'
        puts "Invalid Player Entry."
        redo
      end

      if $player_to_fish_from == fishing_player
        puts "You cannot fish from your own deck!"
        redo
      end

      break

    end

    # this loop requires the user to select a card to fish from
    loop do
      puts "Enter a card (E.G. Jack)"
      $which_card_to_be_fished = $stdin.gets.chomp
      $which_card_to_be_fished.capitalize!
      card_regex = /2|3|4|5|6|7|8|9|10|(Jack)|(Queen)|(King)|(Ace)/
      unless card_regex =~ $which_card_to_be_fished
        puts "Invalid Card Entry."
        redo
      end

      break
    end

    # player must be holding the type of card they are requesting



    # if the player guesses correctly, they gain another turn.

    case $player_to_fish_from
    when 'Player 1'
      @player_1_deck
    when 'Player 2'

      if @player_2_deck.any? { |hash| hash[:card_number] == $which_card_to_be_fished }
        correct_card_count = 0
        @player_2_deck.each do |card|

          if card[:card_number] == $which_card_to_be_fished
          correct_card_count += 1
          @player_1_deck.push(@player_2_deck.delete(card))
          end

        end
        puts "Yes! Player 2 has #{correct_card_count} #{$which_card_to_be_fished}'s"

        display_board

      else
        puts "Sorry, Go Fish!"
        break
      end

    when 'Player 3'
      @player_3_deck
    when 'Player 4'
      @player_4_deck
    end


  end # end main loop
  end

end



class Computer
end

### for computers, allow each computer to 'remember' the last 8 guesses they made (which player and which card)



x = Game.new
# puts x.deck
x.display_board
x.do_you_have_any_of_type_card
