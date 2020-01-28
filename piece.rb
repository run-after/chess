class Piece
  attr_accessor :position, :moves, :team, :OG_position, :first_move
    def initialize(position, round)
      @OG_position = position
      #@round = round
      ### needed for pawn ###
      if round == 1 || round == 2
        move1(position)
      else
        next_move(position, board)
      end
    end

    def enemy_square?(move, board)
      board[move.to_sym] != nil && board[move.to_sym].team != self.team
    end
  
    def empty_square?(move, board)
      (board[move.to_sym] != nil && board[move.to_sym].is_a?(Empty))
    end
end