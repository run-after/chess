require "./piece.rb"
require "pry"
class Bishop < Piece
  def move1(position)
    @position = position
    @moves = []
  end
  def next_move(position, board)
    @position = position
    @moves = []
    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i

    i = 1
    while i < 8
      up_right = position_column[position_column.find_index(column)+i].to_s + (row + i).to_s
      if empty_square?(up_right, board)
        @moves << up_right 
        i+=1
      elsif enemy_square?(up_right, board)###
        @moves << up_right
        if board[up_right.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(up_right, board)###
        i = 8
      else
        i = 8
      end
    end
    
    i = 1
    while i < 8
      down_right = position_column[position_column.find_index(column)+i].to_s + (row - i).to_s
      if empty_square?(down_right, board)
        @moves << down_right
        i+=1
      elsif enemy_square?(down_right, board)###
        @moves << down_right
        if board[down_right.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(down_right, board)###
        i = 8
      else
        i = 8
      end
    end

    i = 1
    while i < 8
      up_left = position_column[position_column.find_index(column)-i].to_s + (row + i).to_s
      if empty_square?(up_left, board)
        @moves << up_left
        i+=1
      elsif enemy_square?(up_left, board)###
        @moves << up_left
        if board[up_left.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(up_left, board)###
        i = 8
      else
        i = 8
      end
    end
    
    i = 1
    while i < 8
      down_left = position_column[position_column.find_index(column)-i].to_s + (row - i).to_s
      if empty_square?(down_left, board)
        @moves << down_left 
        i+=1
      elsif enemy_square?(down_left, board)###
        @moves << down_left 
        if board[down_left.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(down_left, board)###
        i = 8
      else
        i = 8
      end
    end
   
  end
end

class WhiteBishop < Bishop
  
  def team
    "white"
  end
  def show
    "[♝]"
  end
end

class BlackBishop < Bishop
  
  def team
    "black"
  end
  def show
    "[♗]"
  end
end