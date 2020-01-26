require "./piece.rb"
require "pry"
class WhiteBishop < Piece
  def move1(position)
    @team = "white"
    @position = position
    @moves = []
  end
  def next_move(position, board)
    @team = "white"
    @position = position
    @moves = []
    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i
    ### up and to the right ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)+i].to_s + (row + i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "black"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
    ### down and to the right ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)+i].to_s + (row - i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "black"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
    ### up and to the left attack ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)-i].to_s + (row + i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "black"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
    ### down and to the left ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)-i].to_s + (row - i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "black"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
  end

  def show
    "[♝]"
  end
end

class BlackBishop < Piece

  def move1(position)
    @team = "black"
    @position = position
    @moves = []
  end

  def next_move(position, board)
    @team = "black"
    @position = position
    @moves = []
    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i
    ### up and to the right ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)+i].to_s + (row + i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "white"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
    ### down and to the right ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)+i].to_s + (row - i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "white"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
    ### up and to the left attack ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)-i].to_s + (row + i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "white"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
    ### down and to the left ###
    i = 1
    while i < 8
      diagonal_attack = position_column[position_column.find_index(column)-i].to_s + (row - i).to_s
      if (board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].is_a?(Empty))
        @moves << diagonal_attack 
        i+=1
      elsif board[diagonal_attack.to_sym] != nil && board[diagonal_attack.to_sym].team == "white"
        @moves << diagonal_attack
        i = 8
      else
        i = 8
      end
    end
  end
  def show
    "[♗]"
  end
end