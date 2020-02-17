require_relative "../lib/game.rb"

RSpec.describe Rook do 
  describe "#team" do
    it "gives the corresponding color" do
      rook = WhiteRook.new("e4")
      expect(rook.team).to eql("white")
      rook = BlackRook.new("e4")
      expect(rook.team).to eql("black")
    end
  end
  describe "#show" do
    it "prints out the corresponding piece" do
      rook = WhiteRook.new("e4")
      expect(rook.show).to eql("[♜]")
      rook = BlackRook.new("e4")
      expect(rook.show).to eql("[♖]")
    end
  end

  describe "#next_move" do
    it "adds all potential moves to the @moves array" do
      board = Board.new
      empty = Empty.new

      board.board = board.board.each{ |key, value| board.board[key] = empty }

      rook = WhiteRook.new("e4")
      rook.next_move("e4", board.board)
      expect(rook.moves).to eql(["f4", "g4", "h4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", 
                                  "e2", "e1"])
      rook = BlackRook.new("e4")
      rook.next_move("e4", board.board)
      expect(rook.moves).to eql(["f4", "g4", "h4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", 
                                  "e2", "e1"])
    end
    it "makes the last move available the opponent if in line with moves" do
      board = Board.new
      empty = Empty.new
      
      board.board = board.board.each{ |key, value| board.board[key] = empty }

      board.board[:e4] = WhiteRook.new("e4")
      white_rook = board.board[:e4]
      board.board[:f4] = BlackRook.new("f4")
      black_rook = board.board[:f4]
      white_rook.next_move("e4", board.board)
      expect(white_rook.moves).to eql(["f4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
      black_rook.next_move("f4", board.board)
      expect(black_rook.moves).to eql(["g4", "h4", "e4", "f5", "f6", "f7", "f8", "f3", "f2", "f1"])
    end
    it "makes the last move available the team space if in line with moves" do
      board = Board.new
      empty = Empty.new
      
      board.board = board.board.each{ |key, value| board.board[key] = empty }

      board.board[:e4] = WhiteRook.new("e4")
      white_rook = board.board[:e4]
      board.board[:f4] = WhiteRook.new("f4")
      black_rook = board.board[:f4]
      white_rook.next_move("e4", board.board)
      expect(white_rook.moves).to eql(["f4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
      black_rook.next_move("f4", board.board)
      expect(black_rook.moves).to eql(["g4", "h4", "e4", "f5", "f6", "f7", "f8", "f3", "f2", "f1"])
    end
    it "doesn't allow king to move inline with a check i.e. it says rook has available moves through king" do
      board = Board.new
      empty = Empty.new
      
      board.board = board.board.each{ |key, value| board.board[key] = empty }

      board.board[:e4] = WhiteRook.new("e4")
      white_rook = board.board[:e4]
      board.board[:f4] = BlackRook.new("f4")
      black_rook = board.board[:f4]
      board.board[:f5] = WhiteKing.new("f5")
      board.board[:e3] = BlackKing.new("e3")
      white_rook.next_move("e4", board.board)
      expect(white_rook.moves).to eql(["f4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
      black_rook.next_move("f4", board.board)
      expect(black_rook.moves).to eql(["g4", "h4", "e4", "f5", "f6", "f7", "f8", "f3", "f2", "f1"])
    end

  end

end

# can't think of much else I need to prove here --- that might be it... castle is on king, check is on game...
