class Piece
  attr_accessor :position, :moves, :team, :OG_position, :first_move
    def initialize(position, round)
      @OG_position = position
      ### needed for pawn ###
      if round == 1 || round == 2
        move1(position)
      else
        next_move(position, board)
      end
    end
end