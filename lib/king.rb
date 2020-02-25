class King < Piece
  attr_accessor :checked
  def initialize(position, board=nil)
    super
    @checked = false
  end

  def safe_space(move, board)
    enemy_pieces = []
    board.each{ |key, value| enemy_pieces << value if value.is_a?(Piece) && value.team != self.team }

    enemy_pieces.each{ |x| return false if x.moves.include?(move)}
    
    true
  end

  def next_move(position, board)

    @position = position
    @moves = []
    position_column = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    column = position[0]
    row = position[1].to_i
  
    up = column + (row + 1).to_s                                                                                           
    @moves << up if (empty_square?(up, board) || enemy_square?(up, board) || (team_square?(up, board) && !@checked)) && safe_space(up, board)

    upper_right = position_column[position_column.find_index(column)+1].to_s + (row + 1).to_s
    @moves << upper_right if (empty_square?(upper_right, board) || enemy_square?(upper_right, board) || (team_square?(upper_right, board) && !@checked)) && safe_space(upper_right, board)

    right = position_column[position_column.find_index(column)+1].to_s + row.to_s
    @moves << right if (empty_square?(right, board) || enemy_square?(right, board) || (team_square?(right, board) && !@checked)) && safe_space(right, board)

    lower_right = position_column[position_column.find_index(column)+1].to_s + (row - 1).to_s
    @moves << lower_right if (empty_square?(lower_right, board) || enemy_square?(lower_right, board) || (team_square?(lower_right, board) && !@checked)) && safe_space(lower_right, board)
      
    down = column + (row - 1).to_s
    @moves << down if (empty_square?(down, board) || enemy_square?(down, board) || (team_square?(down, board) && !@checked)) && safe_space(down, board)

    lower_left = position_column[position_column.find_index(column)-1].to_s + (row - 1).to_s
    @moves << lower_left if (empty_square?(lower_left, board) || enemy_square?(lower_left, board) || (team_square?(lower_left, board) && !@checked)) && safe_space(lower_left, board)

    left = position_column[position_column.find_index(column)-1].to_s + row.to_s
    @moves << left if (empty_square?(left, board) || enemy_square?(left, board) || (team_square?(left, board) && !@checked)) && safe_space(left, board)

    upper_left = position_column[position_column.find_index(column)-1].to_s + (row + 1).to_s
    @moves << upper_left if (empty_square?(upper_left, board) || enemy_square?(upper_left, board) || (team_square?(upper_left, board) && !@checked)) && safe_space(upper_left, board)

  end
end

class WhiteKing < King

  def next_move(position, board)
    super
    castle_king_side = "h1"
    @moves << castle_king_side if self.first_move == true && board[:f1].is_a?(Empty) && 
                                  board[:g1].is_a?(Empty) && board[:h1].is_a?(Rook) && 
                                  board[:h1].first_move == true && king_side_castleable?(board)
    castle_queen_side = "a1"
    @moves << castle_queen_side if self.first_move == true && board[:d1].is_a?(Empty) && 
                                   board[:c1].is_a?(Empty) && board[:b1].is_a?(Empty) && 
                                   board[:a1].is_a?(Rook) && board[:a1].first_move == true &&
                                   queen_side_castleable?(board)
  end

  def castle_king_side(board)
    if king_side_castleable?(board)
      board[:g1] = board[:e1]
      board[:g1].position = "g1"
      board[:g1].first_move = false
      board[:e1] = Empty.new
      board[:f1] = board[:h1]
      board[:f1].position = "f1"
      board[:f1].first_move = false
      board[:h1] = Empty.new
    end
  end

  def castle_queen_side(board)
    if queen_side_castleable?(board)
      board[:c1] = board[:e1]
      board[:c1].position = "c1"
      board[:c1].first_move = false
      board[:e1] = Empty.new
      board[:d1] = board[:a1]
      board[:d1].position = "d1"
      board[:d1].first_move = false
      board[:a1] = Empty.new
    end
  end

  def king_side_castleable?(board)
    black_pieces = []
    board.each do |key, value|
      black_pieces << value unless value.is_a?(Empty) || value.team != "black" 
    end
    black_pieces.each do |x|
      if x.moves.include?("e1") || x.moves.include?("f1") || x.moves.include?("g1")
        return false
      end
    end
    if !self.first_move = true || !board[:f1].is_a?(Empty) || !board[:g1].is_a?(Empty) || !board[:h1].is_a?(Rook) || 
        !board[:h1].first_move = true
        return false
    end
     true
  end

  def queen_side_castleable?(board)
    black_pieces = []
    board.each do |key, value|
      black_pieces << value unless value.is_a?(Empty) || value.team != "black" 
    end
    black_pieces.each do |x|
      if x.moves.include?("e1") || x.moves.include?("d1") || x.moves.include?("c1")
        return false
      end
    end
    if !self.first_move == true || !board[:d1].is_a?(Empty) || !board[:c1].is_a?(Empty) || !board[:b1].is_a?(Empty) || 
        !board[:a1].is_a?(Rook) || !board[:a1].first_move == true
      return false
    end
    true
  end

  def team
    "white"
  end

  def show
    "[♚]"
  end
end

class BlackKing < King

  def next_move(position, board)
    super

    castle_king_side = "h8"
    @moves << castle_king_side if self.first_move == true && board[:f8].is_a?(Empty) &&   
                                  board[:g8].is_a?(Empty) && board[:h8].is_a?(Rook) && 
                                  board[:h8].first_move == true && king_side_castleable?(board)

    castle_queen_side = "a8"
    @moves << castle_queen_side if self.first_move == true && board[:d8].is_a?(Empty) && 
                                    board[:c8].is_a?(Empty) && board[:b8].is_a?(Empty) && 
                                    board[:a8].is_a?(Rook) && board[:a8].first_move == true &&
                                    queen_side_castleable?(board)

  end

  def castle_king_side(board)
    if king_side_castleable?(board)  
      board[:g8] = board[:e8]
      board[:g8].position = "g8"
      board[:g8].first_move = false
      board[:e8] = Empty.new
      board[:f8] = board[:h8]
      board[:f8].position = "f8"
      board[:f8].first_move = false
      board[:h8] = Empty.new
    end
  end

  def castle_queen_side(board)
    if queen_side_castleable?(board)  
      board[:c8] = board[:e8]
      board[:c8].position = "c8"
      board[:c8].first_move = false
      board[:e8] = Empty.new
      board[:d8] = board[:a8]
      board[:d8].position = "d8"
      board[:d8].first_move = false
      board[:a8] = Empty.new
    end
  end

  def king_side_castleable?(board)
    white_pieces = []
    board.each do |key, value|
      white_pieces << value unless value.is_a?(Empty) || value.team != "white" 
    end
    white_pieces.each do |x|
      if x.moves.include?("e8") || x.moves.include?("f8") || x.moves.include?("g8")
        return false
      end
    end
  end

  def queen_side_castleable?(board)
    white_pieces = []
    board.each do |key, value|
      white_pieces << value unless value.is_a?(Empty) || value.team != "white" 
    end
    white_pieces.each do |x|
      if x.moves.include?("e8") || x.moves.include?("d8") || x.moves.include?("c8")
        return false
      end
    end
  end

  def team
    "black"
  end

  def show
    "[♔]"
  end
end
