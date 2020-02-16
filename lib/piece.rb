class Piece
  attr_reader :team
  attr_accessor :position, :moves, :OG_position, :first_move, :en_passantable, :checker
    def initialize(position, board=nil)
      @OG_position = position
      @checker = false # don't think used
      @first_move = true
      move1(position)
    end

    def enemy_square?(move, board)
      board[move.to_sym] != nil && board[move.to_sym].team != self.team
    end
  
    def empty_square?(move, board)
      (board[move.to_sym] != nil && board[move.to_sym].is_a?(Empty))
    end

    def team_square?(move, board)
      (board[move.to_sym] != nil && board[move.to_sym].team == self.team)
    end
end