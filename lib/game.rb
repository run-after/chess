require "pry"
require "./bishop.rb"
require "./board.rb"
require "./empty.rb"
require "./king.rb"
require "./knight.rb"
require "./pawn.rb"
require "./queen.rb"
require "./rook.rb"

class Game
  attr_reader :round, :board
  def initialize
    @round = 1
    @board = Board.new
    @board.draw
  end

  def play_round
    black_king = find_black_king
    white_king = find_white_king
    if @round % 2 == 0
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
      puts "Enter a valid piece, please"
      puts
      play_round
    end

    print "#{piece} to: "
    destination = gets.chomp
    if !legal_move?(piece, destination)
      
      puts "Enter a valid move, please!"
      puts
      play_round
    else
      ### castling ###
      if piece == "e1" && destination == "h1"
        white_king.castle_king_side(board.board)
        update
        @round += 1
        board.draw
        play_round
      elsif piece == "e1" && destination == "a1"
        white_king.castle_queen_side(board.board)
        update
        @round += 1
        board.draw
        play_round
      elsif piece == "e8" && destination == "h8"
        black_king.castle_king_side(board.board)
        update
        @round += 1
        board.draw
        play_round
      elsif piece == "e8" && destination == "a8"
        black_king.castle_queen_side(board.board)
        update
        @round += 1
        board.draw
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
      check?#might not need this one
      #p black_king
      #p board.board[:e8]
      #p board.board[:d8]
      ### forces next move to remove check ###
      if (player == "white" && white_king.checked) || (player == "black" && black_king.checked)
        puts
        puts "Enter a valid move"
        puts
        move(destination, piece)
        play_round
      end

      @round += 1
      board.draw
      puts "Check." if check?
      update ### not sure if needed. probably not
    
    #p white_king
    
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

  def legal_move?(piece, destination)                     ### below is new ######################to not allow movement when piece wants to move into teammate
    (board.board[piece.to_sym].moves.include?(destination))# && (board.board[destination.to_sym].team != board.board[piece.to_sym].team)
  end

  def update
    board.board.each{ |key, value| value.next_move(value.position, board.board) if value.is_a?(Piece)}
  end

  def move(piece, destination)
    if (board.board[destination.to_sym].team != board.board[piece.to_sym].team)###################to not allow movement when piece wants to move into teammate
    board.board[destination.to_sym] = board.board[piece.to_sym]
    board.board[destination.to_sym].next_move(destination, board.board)
    board.board[destination.to_sym].first_move = false
    board.board[piece.to_sym] = Empty.new
    end##########################to not allow movement when piece wants to move into teammate
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
### works with priliminary testing... 
  def no_blocker(player)
    #binding.pry
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
  ### I'm pretty sure I can get rid of #no_bodyguard
  def no_bodyguard(player)
    ### if piece can kill checker - seems to be working
    team_pieces = []
    checker = ''
    board.board.each{ |key, value| checker << value.position if value.is_a?(Piece) && value.checker == true }
    board.board.each{ |key, value| team_pieces << value if value.team == player}

    team_pieces.each{ |x| return false if x.moves.include?(checker)}
    true
  end

  def checkmate?(player)
    
    check? && no_king_moves(player) && no_blocker(player)# && no_bodyguard(player)
  end

end
game = Game.new
game.play_round


### pawn class is real ugly ###

=begin

@chase Hi mate, sorry for the radio silence. I've had a look at your code and 
for the most part it's actually pretty good, but there is still a lot of 
repetition that could be extracted. In your bishop class for example all of
the lines do the same thing, except just move in different direction. Could you 
extract those directions to an array or hash and then iterate those?

@chase The draw method in your board class is crying out for iteration
@chase Even the creation of the board could be extracted
By creation of the board I meant in the initialize method

=end