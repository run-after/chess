require "yaml"
require_relative "./piece.rb"
require_relative "./board.rb"
require_relative "./empty.rb"
require_relative "./king.rb"
require_relative "./knight.rb"
require_relative "./pawn.rb"
require_relative "./queen.rb"
require_relative "./rook.rb"
require_relative "./bishop.rb"

class Game
  attr_reader :round, :board
  def initialize(board=Board.new)
    @board = board
  end

  def play_round
    @board.draw
    puts
    puts "You can save the game by typing 'SAVE' during your piece selection"
    puts
    black_king = find_black_king
    white_king = find_white_king
    if board.round % 2 == 0
      player = "black" 
      ### resets the ability for en passant ###
      board.board.each{ |key, value| value.en_passantable = false if value.is_a?(BlackPawn)}
    else
      player = "white"
      ### resets the ability for en passant ###
      board.board.each{ |key, value| value.en_passantable = false if value.is_a?(WhitePawn)}
    end
  
    print "#{player.capitalize}, choose piece to move: "
    piece = gets.chomp
    
    if !board.board.include?(piece.to_sym) || piece == nil ||
        board.board[piece.to_sym].team != player
      if piece == "SAVE"
          save(board)
          exit
      else
        puts "Enter a valid piece, please"
        puts
        play_round
      end
    end

    print "#{piece} to: "
    destination = gets.chomp
    if !legal_move?(piece, destination)
      
      puts "Enter a valid move, please!"
      puts
      play_round
    else
      ### castling ###
      if castle(piece, destination)
        play_round
      end

      ### en passant(tells us that it is possiible to kill this piece) ###
      if board.board[piece.to_sym].is_a?(Pawn) && (piece[1].to_i - destination[1].to_i).abs == 2
        board.board[piece.to_sym].en_passantable = true
      end
      #### en passant(removes the piece that was killed) ###
      if board.board[piece.to_sym].is_a?(WhitePawn) && board.board[piece.to_sym].en_passant.include?(destination)
        temp = destination[0] + (destination[1].to_i - 1).to_s
        board.board[temp.to_sym] = Empty.new
      elsif board.board[piece.to_sym].is_a?(BlackPawn) && board.board[piece.to_sym].en_passant.include?(destination)
        temp = destination[0] + (destination[1].to_i + 1).to_s
        board.board[temp.to_sym] = Empty.new
      end

      move(piece, destination)
      update
      check?

      if (player == "white" && white_king.checked) || (player == "black" && black_king.checked)
        puts
        puts "Enter a valid move"
        puts
        move(destination, piece)
        play_round
      end
      board.round += 1
      board.draw
      puts "Check." if check?
      update
    if checkmate?(player)
      puts "#{player.capitalize} wins!"
      exit
    end
      play_round
    end
  end

  def check?
    black_king = find_black_king
    white_king = find_white_king

    pieces = []
    board.board.each{ |key, value| pieces << value unless value.is_a?(Empty) }
    pieces.each do |x| 
      if x.team == "black" && x.moves.include?(white_king.position)
        white_king.checked = true
        x.checker = true
        return true
      else
        white_king.checked = false 
        x.checker = false
      end
      
      if x.team == "white" && x.moves.include?(black_king.position)
        black_king.checked = true
        x.checker = true
        return true
      else
        black_king.checked = false
        x.checker = false
      end
    end
    black_king.checked == true || white_king.checked == true
  end

  def find_white_king
    board.board.each{ |key, value| return value if value.is_a?(WhiteKing) }
  end

  def find_black_king
    board.board.each{ |key, value| return value if value.is_a?(BlackKing) }
  end

  def legal_move?(piece, destination)                     
    (board.board[piece.to_sym].moves.include?(destination))
  end

  def update
    board.board.each{ |key, value| value.next_move(value.position, board.board) if value.is_a?(Piece)}
  end

  def move(piece, destination)
    if (board.board[destination.to_sym].team != board.board[piece.to_sym].team)
      board.board[destination.to_sym] = board.board[piece.to_sym]
      board.board[destination.to_sym].next_move(destination, board.board)
      board.board[destination.to_sym].first_move = false
      board.board[piece.to_sym] = Empty.new
    end
  end

  def no_king_moves(player)
    if player == "white"
      if find_black_king.moves.size < 1
        true
      else 
        false
      end
    else
      if find_white_king.moves.size < 1
        true
      else
        false
      end
    end
  end
  
  def no_blocker(player)
    team_pieces = []
    board.board.each{ |key, value| team_pieces << value if value.is_a?(Piece) && value.team != player}
    if team_pieces.size > 0
      team_pieces.each do |x|  
      if x.moves.size > 0
        temp = x.position
        x.moves.each do |y| 
          move(x.position, y)
          update
          if !check?
            move(y, temp)
            update
            return false
          else
            move(y, temp)
            update
          end
        end
      else
        true
      end
      end
    else
      return true
    end
    true
  end
 
  def checkmate?(player)
    check? && no_king_moves(player) && no_blocker(player)
  end

  def castle(piece, destination)
    if piece == "e1" && destination == "h1"
      find_white_king.castle_king_side(board.board)
      update
      board.round += 1
      return true
    elsif piece == "e1" && destination == "a1"
      find_white_king.castle_queen_side(board.board)
      update
      board.round += 1
      return true 
    elsif piece == "e8" && destination == "h8"
      find_black_king.castle_king_side(board.board)
      update
      board.round += 1
      return true 
    elsif piece == "e8" && destination == "a8"
      find_black_king.castle_queen_side(board.board)
      update
      board.round += 1
      return true 
    end
    false 
  end

  def load(filename)
    file = File.open(filename, "r")
    contents = YAML::load(file)
    board = contents
    game = Game.new(board)
    game.play_round
  end
  
  def save(board)
    current_game = YAML::dump(board)
    Dir.mkdir("../games") unless Dir.exists? "../games"
    print "Enter filename: "
    filename = gets.chomp
    filename.prepend("../games/")
    filename += ".yaml"
    File.open(filename,'w') do |file|
      file.puts current_game
    end
  end
  
  def new_game
    print "Would you like to LOAD a game or play a NEW one: "
    ans = gets.chomp
    if ans == "LOAD"
      print "Enter filename: "
      filename = gets.chomp
      load(filename)
      play_round
    else
      play_round
    end
  end

end