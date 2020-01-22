class Rook
  attr_accessor :position
  def initialize(position)
    @position = position
  end
end

class WhiteRook < Rook
  def show
    "[♜]"
  end
end

class BlackRook < Rook
  def show
    "[♖]"
  end
end
