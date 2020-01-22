
class King
  attr_accessor :position
  def initialize(position)
    @position = position
  end
end

class WhiteKing < King
  def show
    "[♚]"
  end
end

class BlackKing < King
  def show
    "[♔]"
  end
end
