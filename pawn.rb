require "./piece.rb"

class WhitePawn < Piece  

  def move1(position)
    @team = "white"
    @position = position
    @first_move = position == @OG_position
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
    @first_move = position == @OG_position 

    position_column = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
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
    if board[diagonal_attack.to_sym].is_a?(Piece) && board[diagonal_attack.to_sym].team == "black"
      @moves << diagonal_attack
    end
    
    diagonal_attack = position_column[position_column.find_index(column)-1].to_s + (row + 1).to_s
    if board[diagonal_attack.to_sym].is_a?(Piece) && board[diagonal_attack.to_sym].team == "black" 
      @moves << diagonal_attack
    end
    ### en passant ###
    #if position[1] == "5"
    #  if 
    #  end
    #end


      ### if pawn makes it all the way to last rank ###
    if position[1] == "8"
      puts "What would you like to upgrade to?"
      print "1: Queen 2: Rook 3: Knight 4: Bishop "
      ans = gets.chomp

      case ans
      when "1"
        board[position.to_sym] = WhiteQueen.new(position)
      when "2"
        board[position.to_sym] = WhiteRook.new(position)
      when "3"
        board[position.to_sym] = WhiteKnight.new(position)
      when "4"
        board[position.to_sym] = WhiteBishop.new(position)
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

class BlackPawn < Piece

  def move1(position)
    @team = "black"
    @position = position
    @first_move = position == @OG_position
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
    @first_move = position == @OG_position
    ### if pawn makes it all the way to last rank ###
    if position[1] == "1"
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

    position_column = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
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
  end

  def show
    "[♙]"
  end

end

### still need en passent. Other than that, this piece is complete!
