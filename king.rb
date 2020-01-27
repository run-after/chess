require "./piece.rb"

class WhiteKing < Piece

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
  
    up = column[0] + (row + 1).to_s
    @moves << up if empty_square?(up, board) || enemy_square?(up, board)

    upper_right = position_column[position_column.find_index(column)+1].to_s + (row + 1).to_s
    @moves << upper_right if empty_square?(upper_right, board) || enemy_square?(upper_right, board)

    right = position_column[position_column.find_index(column)+1].to_s + row.to_s
    @moves << right if empty_square?(right, board) || enemy_square?(right, board)

    lower_right = position_column[position_column.find_index(column)+1].to_s + (row - 1).to_s
    @moves << lower_right if empty_square?(lower_right, board) || enemy_square?(lower_right, board)

    down = column[0] + (row - 1).to_s
    @moves << down if empty_square?(down, board) || enemy_square?(down, board)

    lower_left = position_column[position_column.find_index(column)-1].to_s + (row - 1).to_s
    @moves << lower_left if empty_square?(lower_left, board) || enemy_square?(lower_left, board)

    left = position_column[position_column.find_index(column)-1].to_s + row.to_s
    @moves << left if empty_square?(left, board) || enemy_square?(left, board)

    upper_left = position_column[position_column.find_index(column)-1].to_s + (row + 1).to_s
    @moves << upper_left if empty_square?(upper_left, board) || enemy_square?(upper_left, board)
        
  end

  def show
    "[♚]"
  end
end

class BlackKing < Piece

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
  
    up = column[0] + (row + 1).to_s
    @moves << up if empty_square?(up, board) || enemy_square?(up, board)

    upper_right = position_column[position_column.find_index(column)+1].to_s + (row + 1).to_s
    @moves << upper_right if empty_square?(upper_right, board) || enemy_square?(upper_right, board)

    right = position_column[position_column.find_index(column)+1].to_s + row.to_s
    @moves << right if empty_square?(right, board) || enemy_square?(right, board)

    lower_right = position_column[position_column.find_index(column)+1].to_s + (row - 1).to_s
    @moves << lower_right if empty_square?(lower_right, board) || enemy_square?(lower_right, board)

    down = column[0] + (row - 1).to_s
    @moves << down if empty_square?(down, board) || enemy_square?(down, board)

    lower_left = position_column[position_column.find_index(column)-1].to_s + (row - 1).to_s
    @moves << lower_left if empty_square?(lower_left, board) || enemy_square?(lower_left, board)

    left = position_column[position_column.find_index(column)-1].to_s + row.to_s
    @moves << left if empty_square?(left, board) || enemy_square?(left, board)

    upper_left = position_column[position_column.find_index(column)-1].to_s + (row + 1).to_s
    @moves << upper_left if empty_square?(upper_left, board) || enemy_square?(upper_left, board)
    
  end

  def show
    "[♔]"
  end
end
