# coding: utf-8

require 'model/Card'

class Deck
  
  attr_accessor :cardsLeftInDeck, :cards
  
  def initialize()
    #suits = ['S','D','C','H']
    suits = ['♠', '◆', '♣', '♥'] 
    cardNums = [2,3,4,5,6,7,8,9,10,'J','Q','K','A']
    @cards = []
    suits.each { |suit|
     cardNums.each { |cardNum|
       card = Card.new
       card.cardNumber=(cardNum)
       card.suit=(suit)
       @cards << card
     }
    }
    srand
    200.times { randomizeCards() }
    @cardsLeftInDeck = suits.length * cardNums.length()
    
  end
  def randomizeCards()
    
    rand1 = rand(@cards.length)
    rand2 = rand(@cards.length())
    temp = @cards[rand1]
    @cards[rand1] = @cards[rand2]
    @cards[rand2] = temp
  
  end
  def getCard()
   card, *@cards = @cards
   @cardsLeftInDeck = @cards.length
   return card
  end
end
