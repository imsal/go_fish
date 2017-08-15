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
    suites = ['of Hearts', 'of Spades', 'of Clubs', 'of Diamonds']

    deck = []

    numbers.each do |num|
      suites.each do |suite|
        deck.push("#{num} #{suite}")
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

  def display_board
    puts "Cards left in stock: #{@deck.count}"
    puts "Player 1: #{@player_1_deck}"
    puts "Player 2: #{@player_2_deck}"
    puts "Player 3: #{@player_3_deck}"
    puts "Player 4: #{@player_4_deck}"
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
  #
  # def select_player_deck(player)
  #   case player
  #   when 'Player 1'
  #     return @player_1_deck
  #   when 'Player 2'
  #     return @player_2_deck
  #   when 'Player 3'
  #     return @player_3_deck
  #   when 'Player 4'
  #     return @player_4_deck
  #   end
  # end

  def do_you_have_any_of_type_card
    fishing_player=@which_players_turn
    # fishing_deck=select_player_deck(fishing_player)

    loop do
    puts "Enter a player (E.G. player 3)"
    player_to_fish_from = $stdin.gets.chomp
    puts "Enter a card (E.G. Jack)"
    which_card_to_be_fished = $stdin.gets.chomp
    # player must be holding the type of card they are requesting



    # if the player guesses correctly, they gain another turn.
    

    end
  end

end


x = Game.new
# puts x.deck
x.display_board
x.do_you_have_any_of_type_card
