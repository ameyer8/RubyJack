require 'model/Deck'

class Hand
  
  attr_accessor :cardsHolding, :hide

  def initialize 
    @cardsHolding = Array.new
    @player = ""
  end
  def player=(playerName) 
    @player = playerName
    if playerName.eql?("Dealer")
      @hide = true
    else
      @hide = false
    end
  end
  def player
    return @player
  end
  
  def addCard(card)
    @cardsHolding << card
  end
  def to_s()
    i = 0
    cards = @cardsHolding.length()
    str = ""
    str += "#{player.capitalize}'s Hand \n"
    until cards == 0 do
      if cards > 4
        printWidth = 4
      else
        printWidth = cards
      end
      
      printWidth.times { str += " --------- \t" }
      str += "\n" 
      printWidth.times {
        if @cardsHolding[i].cardNumber == 10
          formatSpace = ''
        else
          formatSpace = ' '
        end
        if @hide and i==0     
          str +="|         |\t"
        else
          str += "| #{@cardsHolding[i].cardNumber}      #{formatSpace}| \t"
        end
        i += 1
      }
      str += "\n" 
      i -=printWidth
      printWidth.times { str += "|         |\t" }
      str += "\n" 
      printWidth.times { 
        if @hide and i==0     
          str +="|         |\t"
        else
          str +="|    #{@cardsHolding[i].suit}    |\t" 
        end
        i+=1 
      }
      str +="\n"
      i -= printWidth
      printWidth.times { str +="|         |\t"}
      str += "\n" 
      printWidth.times { 
        if @cardsHolding[i].cardNumber == 10
          formatSpace = ''
        else
          formatSpace = ' '
        end
        
        if @hide and i==0     
          str +="|         |\t"
        else
          str += "|      #{formatSpace}#{@cardsHolding[i].cardNumber} |\t"
        end
        i += 1
      }
      str += "\n"
      printWidth.times { str += " --------- \t" }
      str += "\n" 
      cards -= printWidth
    end
    return str
  end
  
end
