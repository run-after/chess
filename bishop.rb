
class Bishop
  attr_accessor :position
  def initialize(position)
    @position = position
  end
end

class WhiteBishop < Bishop
  def show
    "[♝]"
  end
end

class BlackBishop < Bishop
  def show
    "[♗]"
  end
end
