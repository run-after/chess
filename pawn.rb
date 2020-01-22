class Pawn
  attr_accessor :position, :moves
  def initialize(position)
    
  end
end

class WhitePawn < Pawn  
  

  def show
    "[♟]"
  end

end

class BlackPawn < Pawn
  
  
  def show
    "[♙]"
  end

end
