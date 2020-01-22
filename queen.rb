class Queen
  attr_accessor :position
  def initialize(position)
    @position = position
  end
end

class WhiteQueen < Queen
  def show
    "[♛]"
  end
end

class BlackQueen < Queen
  def show
    "[♕]"
  end
end
