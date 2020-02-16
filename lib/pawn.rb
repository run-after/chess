require "./piece.rb"
class Pawn < Piece
  attr_reader :en_passant
  def initialize(position, board=nil)
    super
    @en_passantable = false
    @en_passant = [] #pretty sure this is useless
    #@first_move = position == @OG_position
  end
end

class WhitePawn < Pawn

  def move1(position)
    @team = "white"
    @position = position
    column = position[0]
    row = position[1].to_i
    @moves = []
    @moves << column + (row + 2).to_s
    @moves << column + (row + 1).to_s
  end

  def next_move(position, board)
    
    @team = "white"
    @position = position
    @moves = []

    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i

    ### straight 1 square move ###
    @moves << column + (row + 1).to_s if board[(column + (row + 1).to_s).to_sym].is_a?(Empty)#  
    ### straight 2 square move ###
    if @first_move && board[(column + (row + 2).to_s).to_sym].is_a?(Empty) && board[(column + (row + 1).to_s).to_sym].is_a?(Empty)
      @moves << column + (row + 2).to_s 
    end
    ### diagonal attacks ###
    diagonal_attack = position_column[position_column.find_index(column)+1].to_s + (row + 1).to_s
    if enemy_square?(diagonal_attack, board) || team_square?(diagonal_attack, board)#board[diagonal_attack.to_sym].is_a?(Piece) && board[diagonal_attack.to_sym].team == "black"
      @moves << diagonal_attack                   # ^^ this is for backing up a piece checking king
    end
    ### this isn't working for some reason ########
    diagonal_attack = position_column[position_column.find_index(column)-1].to_s + (row + 1).to_s
    if enemy_square?(diagonal_attack, board) || team_square?(diagonal_attack, board)#board[diagonal_attack.to_sym].is_a?(Piece) && board[diagonal_attack.to_sym].team == "black" 
      @moves << diagonal_attack                   # ^^ this is for backing up a piece checking king
    end
    ### en passant(allows attack) ###
    if row == 5
      next_to = position_column[position_column.find_index(column)+1].to_s + row.to_s
      diagonal_attack = position_column[position_column.find_index(column)+1].to_s + (row + 1).to_s
      if board[next_to.to_sym].is_a?(BlackPawn) && board[next_to.to_sym].en_passantable
        @moves << diagonal_attack
        @en_passant << diagonal_attack#pretty sure this is useless
      end

      next_to = position_column[position_column.find_index(column)-1].to_s + row.to_s
      diagonal_attack = position_column[position_column.find_index(column)-1].to_s + (row + 1).to_s
      if board[next_to.to_sym].is_a?(BlackPawn) && board[next_to.to_sym].en_passantable 
        @moves << diagonal_attack
        @en_passant << diagonal_attack#pretty sure this is useless
      end
    end

      ### if pawn makes it all the way to last rank ###
    if row == 8
      puts "What would you like to upgrade to?"
      print "1: Queen 2: Rook 3: Knight 4: Bishop "
      ans = gets.chomp

      case ans
      when "1"
        board[position.to_sym] = WhiteQueen.new(position, board)
      when "2"
        board[position.to_sym] = WhiteRook.new(position, board)
      when "3"
        board[position.to_sym] = WhiteKnight.new(position, board)
      when "4"
        board[position.to_sym] = WhiteBishop.new(position, board)
      else
        puts "Invalid number"
        next_move(position, board)
      end
    end
  end

  def show
    "[♟]"
  end

end

class BlackPawn < Pawn

  def move1(position)
    @team = "black"
    @position = position
    column = position[0]
    row = position[1].to_i
    @moves = []
    @moves << column + (row - 2).to_s
    @moves << column + (row - 1).to_s
  end

  def next_move(position, board)
    @team = "black"
    @position = position
    @moves = []

    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i

    ### straight 1 square move ###
    @moves << column + (row - 1).to_s if board[(column + (row - 1).to_s).to_sym].is_a?(Empty)# 
    ### straight double move ###
    if @first_move && board[(column + (row - 2).to_s).to_sym].is_a?(Empty) && board[(column + (row - 1).to_s).to_sym].is_a?(Empty)
      @moves << column + (row - 2).to_s 
    end
    ### diagonal attacks ###
    diagonal_attack = position_column[position_column.find_index(column)+1].to_s + (row - 1).to_s
    if board[diagonal_attack.to_sym].is_a?(Piece) && board[diagonal_attack.to_sym].team == "white"
      @moves << diagonal_attack
    end

    diagonal_attack = position_column[position_column.find_index(column)-1].to_s + (row - 1).to_s
    if board[diagonal_attack.to_sym].is_a?(Piece) && board[diagonal_attack.to_sym].team == "white" 
      @moves << diagonal_attack
    end

    ### en passant ###
    if row == 4
      next_to = position_column[position_column.find_index(column)+1].to_s + row.to_s
      diagonal_attack = position_column[position_column.find_index(column)+1].to_s + (row - 1).to_s
      if board[next_to.to_sym].is_a?(WhitePawn) && board[next_to.to_sym].en_passantable
        @moves << diagonal_attack
        @en_passant << diagonal_attack#pretty sure this is useless
      end

      next_to = position_column[position_column.find_index(column)-1].to_s + row.to_s
      diagonal_attack = position_column[position_column.find_index(column)-1].to_s + (row - 1).to_s
      if board[next_to.to_sym].is_a?(WhitePawn) && board[next_to.to_sym].en_passantable 
        @moves << diagonal_attack
        @en_passant << diagonal_attack#pretty sure this is useless
      end
    end

    ### if pawn makes it all the way to last rank ###
    if row == 1
      puts "What would you like to upgrade to?"
      print "1: Queen 2: Rook 3: Knight 4: Bishop "
      ans = gets.chomp
    
      case ans
      when "1"
        board[position.to_sym] = BlackQueen.new(position)
      when "2"
        board[position.to_sym] = BlackRook.new(position)
      when "3"
        board[position.to_sym] = BlackKnight.new(position)
      when "4"
        board[position.to_sym] = BlackBishop.new(position)
      else
        puts "Invalid number"
        next_move(position, board)
      end
    end
    
  end

  def show
    "[♙]"
  end

end

# Need to clean up this class. The King class is probably best example to follow