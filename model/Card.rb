class Card
  
  attr_accessor :suit, :cardNumber
  
 def initalizate()
 end 
 
 def to_s()   
  
   if @cardNumber == 10
     formatSpace = ''
   else
     formatSpace = ' '
   end
   str = "This card is:  
    ---------
   | #{cardNumber}      #{formatSpace}| 
   |         |
   |    #{suit}    |
   |         |
   |      #{formatSpace}#{cardNumber} |
    ---------"
   return str
 end
end


