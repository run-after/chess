require "./piece.rb"

class Knight < Piece

  def move1(position)
    @position = position
    @moves = []
    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i
    upper_right = position_column[position_column.find_index(column)+1].to_s + (row + 2).to_s
    @moves << upper_right 
    upper_left = position_column[position_column.find_index(column)-1].to_s + (row + 2).to_s
    @moves << upper_left 
    lower_right = position_column[position_column.find_index(column)+1].to_s + (row - 2).to_s
    @moves << lower_right 
    lower_left = position_column[position_column.find_index(column)-1].to_s + (row - 2).to_s
    @moves << lower_left 
  end

  def next_move(position, board)
    @position = position
    @moves = []
    
    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i
  
    upper_right = position_column[position_column.find_index(column)+1].to_s + (row + 2).to_s
    @moves << upper_right if empty_square?(upper_right, board) || enemy_square?(upper_right, board) || team_square?(upper_right, board)###

    righter_up = position_column[position_column.find_index(column) + 2].to_s + (row + 1).to_s
    @moves << righter_up if empty_square?(righter_up, board) || enemy_square?(righter_up, board) || team_square?(righter_up, board)###

    righter_low = position_column[position_column.find_index(column)+2].to_s + (row - 1).to_s
    @moves << righter_low if empty_square?(righter_low, board) || enemy_square?(righter_low, board) || team_square?(righter_low, board)###

    lower_right = position_column[position_column.find_index(column)+1].to_s + (row - 2).to_s
    @moves << lower_right if empty_square?(lower_right, board) || enemy_square?(lower_right, board) || team_square?(lower_right, board)###

    upper_left = position_column[position_column.find_index(column)-1].to_s + (row + 2).to_s
    @moves << upper_left if empty_square?(upper_left, board) || enemy_square?(upper_left, board) || team_square?(upper_left, board)###

    lefter_up = position_column[position_column.find_index(column)-2].to_s + (row + 1).to_s
    @moves << lefter_up if empty_square?(lefter_up, board) || enemy_square?(lefter_up, board) || team_square?(lefter_up, board)###

    lefter_low = position_column[position_column.find_index(column)-2].to_s + (row - 1).to_s
    @moves << lefter_low if empty_square?(lefter_low, board) || enemy_square?(lefter_low, board) || team_square?(lefter_low, board)###

    lower_left = position_column[position_column.find_index(column)-1].to_s + (row - 2).to_s
    @moves << lower_left if empty_square?(lower_left, board) || enemy_square?(lower_left, board) || team_square?(lower_left, board)### to back up checking piece

  end

end

class WhiteKnight < Knight
  
  def team
    "white"
  end
  
  def show
    "[♞]"
  end
end

class BlackKnight < Knight

  def team
    "black"
  end

  def show
    "[♘]"
  end
end
