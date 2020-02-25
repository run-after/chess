class Queen < Piece

  def next_move(position, board)
    @position = position
    @moves = []
    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i
    column_number = position_column.find_index(column)
### diagonals ###
    i = 1
    while i < 8
      up_right = position_column[column_number + i].to_s + (row + i).to_s
      if empty_square?(up_right, board)
        @moves << up_right 
        i+=1
      elsif enemy_square?(up_right, board)
        @moves << up_right
        if board[up_right.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(up_right, board)
        @moves << up_right
        i = 8
      else
        i = 8
      end
    end
    
    i = 1
    while i < 8
      down_right = position_column[column_number + i].to_s + (row - i).to_s
      if empty_square?(down_right, board)
        @moves << down_right
        i+=1
      elsif enemy_square?(down_right, board)
        @moves << down_right
        if board[down_right.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(down_right, board)
        @moves << down_right
        i = 8
      else
        i = 8
      end
    end

    i = 1
    while i < 8
      up_left = position_column[column_number - i].to_s + (row + i).to_s
      if empty_square?(up_left, board)
        @moves << up_left
        i+=1
      elsif enemy_square?(up_left, board)
        @moves << up_left
        if board[up_left.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(up_left, board)
        @moves << up_left
        i = 8
      else
        i = 8
      end
    end
    
    i = 1
    while i < 8
      down_left = position_column[column_number - i].to_s + (row - i).to_s
      if empty_square?(down_left, board)
        @moves << down_left 
        i+=1
      elsif enemy_square?(down_left, board)
        @moves << down_left
        if board[down_left.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(down_left, board)
        @moves << down_left 
        i = 8
      else
        i = 8
      end
    end
### straight moves ###    
    i = 1
    while i < 8
      right = position_column[column_number + i].to_s + row.to_s
      if empty_square?(right, board)
        @moves << right
        i+=1
      elsif enemy_square?(right, board)
        @moves << right
        if board[right.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(right, board)
        @moves << right
        i = 8
      else
        i = 8
      end
    end

    i = 1
    while i < 8
      left = position_column[column_number - i].to_s + row.to_s
      if empty_square?(left, board)
        @moves << left
        i+=1
      elsif enemy_square?(left, board)
        @moves << left
        if board[left.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(left, board)
        @moves << left
        i = 8
      else
        i = 8
      end
    end

    i = 1
    while i < 8
      up = column + (row + i).to_s
      if empty_square?(up, board)
        @moves << up
        i+=1
      elsif enemy_square?(up, board)
        @moves << up
        if board[up.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(up, board)
        @moves << up
        i = 8
      else
        i = 8
      end
    end

    i = 1
    while i < 8
      down = column + (row - i).to_s
      if empty_square?(down, board)
        @moves << down
        i+=1
      elsif enemy_square?(down, board)
        @moves << down
        if board[down.to_sym].is_a?(King)
          i += 1
        else
          i = 8
        end
      elsif team_square?(down, board)
        @moves << down
        i = 8
      else
        i = 8
      end
    end

  end
end
class WhiteQueen < Queen

  def team
    "white"
  end

  def show
    "[♛]"
  end
end

class BlackQueen < Queen

  def team
    "black"
  end
  
  def show
    "[♕]"
  end
end
