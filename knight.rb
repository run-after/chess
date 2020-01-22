class Knight
  attr_accessor :position
  def initialize(position)
    @position = position
  end
end

class WhiteKnight < Knight
  def show
    "[♞]"
  end
end

class BlackKnight < Knight
  def show
    "[♘]"
  end
end
