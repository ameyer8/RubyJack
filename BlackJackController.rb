# coding: utf-8

require 'model/Hand'
require 'model/Deck'

class BlackJackController
  
  attr_accessor :deck, :playerHand, :dealerHand, :onGame, :wins, :total, :bank, :bet
  def initialize
    @deck = Deck.new
    @bank = 100
    @wins = 0
    @total = 0
  end
  def hit(hand)
    hand.cardsHolding << @deck.getCard
  end
  def playGame
    @bet = 0
    puts ("You have #{@bank} dollars")
    print("Bet: ")
    until @bet > 0 and @bet <= @bank do
      @bet = gets().to_i
      if @bet == 0
          @bet = @bank/2
      end
    end

    @playerHand = Hand.new
    @playerHand.player=("Human")
    @dealerHand = Hand.new
    @dealerHand.player=("Dealer")

    @onGame = true
    
    2.times{
      @playerHand.cardsHolding << @deck.getCard
      @dealerHand.cardsHolding << @deck.getCard
    }
    printHands
    checkWin(countCards(@playerHand),countCards(@dealerHand), 'h')

    while @onGame
      printf("Next move? ")
      move = gets.chomp
      
      if move.eql?("hit") or move.eql?('h')
        if countCards(@dealerHand) < 17
          hit(@dealerHand)
        end
        hit(@playerHand)
        printHands
        checkWin(countCards(@playerHand),countCards(@dealerHand), 'h')
      elsif move.eql?("stay") or move.eql?('s')
        if countCards(@dealerHand) >= countCards(@playerHand)
          checkWin(countCards(@playerHand),countCards(@dealerHand), 's')
        else
          while countCards(@playerHand) >= countCards(@dealerHand)
            hit(@dealerHand)
            checkWin(countCards(@playerHand),countCards(@dealerHand), 's')
          end
        end
      end
    end
  end
  def countCards(hand)
    handCount = 0
    hand.cardsHolding.each { |card|
    
      if card.cardNumber.to_i < 11 and card.cardNumber.to_i > 0
        handCount += card.cardNumber
      elsif card.cardNumber == 'J' || card.cardNumber == 'Q' || card.cardNumber == 'K' 
        handCount += 10
      elsif (handCount + 11) < 22 
         handCount += 11
      else
        handCount += 1
      end
    }
    return handCount 
  end
  def checkWin(pHandCount, dHandCount, move)
    if pHandCount == 21
      @dealerHand.hide=(false)
      printHands
      puts "Player Wins! (21)"
      @onGame = false
      @wins += 1
      @total += 1
      @bank += @bet
    end
    if pHandCount >21 and @onGame
      @dealerHand.hide=(false)
      printHands
      puts "Player Loses (PL)"
      @onGame = false
      @total += 1
      @bank -= @bet
    end
    if dHandCount > 21 and @onGame
      @dealerHand.hide=(false)
      printHands
      puts "Player Wins! (DL)"
      @onGame = false
      @wins += 1
      @total += 1
      @bank += @bet
    end
    if move.eql?('s') 
      if dHandCount > pHandCount and @onGame
        @dealerHand.hide=(false)
        printHands
        puts "Player Loses (s)"
        @onGame = false
        @total += 1
        @bank -= @bet
        
      else
          if dHandCount == pHandCount and @onGame
            @dealerHand.hide=(false)
            printHands
            puts "Push"
            @onGame = false
          end
      end
    end

   puts "You have won #{@wins} out of #{@total}"
  end
  def printHands
    puts @playerHand
    puts @dealerHand
  end
end

c = BlackJackController.new
cont = true
while cont
  c.playGame()
  if c.deck.cards.length < 15 
    puts "getting new deck"
    newDeck = Deck.new
    newDeck.cards.each { |card|
      c.deck.cards << card
    }
    puts "shoe now has #{c.deck.cards.length} cards"
  end
  if c.bank() < 1 
    cont = false
    puts("You're Done, loser!")
  else
    print("Play again (y/n): ")
    resp = gets.chomp
    if resp.eql?('n')
      cont = false
    end
  end
  
end
