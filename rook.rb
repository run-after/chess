require "./piece.rb"

class Rook < Piece

  def move1(position)
    @position = position
    @moves = []
  end

  def next_move(position, board)
    @position = position
    @moves = []
    i = 1
    while i < 8
      right = position_column[column_number + i].to_s + row.to_s
      if empty_square?(right, board)
        @moves << right
        i+=1
      elsif enemy_square?(right, board)
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
        i = 8
      else
        i = 8
      end
    end
  end

end

class WhiteRook < Rook

  def team
    "white"
  end

  def show
    "[♜]"
  end
end

class BlackRook < Rook

  def team
    "black"
  end
  
  def show
    "[♖]"
  end
end
