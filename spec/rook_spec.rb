require_relative "../lib/game.rb"

RSpec.describe Rook do 
  describe "#initialize" do
    it "creates a white rook on position e4" do
      board = Board.new
      board.board[:e4] = WhiteRook.new("e4")
      expect(board.board[:e4].is_a?(WhiteRook)).to eql(true)
    end
  end
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
      board.board = {:a1 => empty, :b1 => empty, :c1 => empty, :d1 => empty, :e1 => empty, :f1 => empty, 
                     :g1 => empty, :h1 => empty,
    
                     :a2 => empty, :b2 => empty, :c2 => empty, :d2 => empty, :e2 => empty, :f2 => empty, 
                     :g2 => empty, :h2 => empty,
    
                    :a3 => empty, :b3 => empty, :c3 => empty, :d3 => empty, :e3 => empty, :f3 => empty,
                    :g3 => empty, :h3 => empty,
    
                    :a4 => empty, :b4 => empty, :c4 => empty, :d4 => empty, :e4 => empty, :f4 => empty,
                    :g4 => empty, :h4 => empty,
    
                    :a5 => empty, :b5 => empty, :c5 => empty, :d5 => empty, :e5 => empty, :f5 => empty,
                    :g5 => empty, :h5 => empty,
    
                    :a6 => empty, :b6 => empty, :c6 => empty, :d6 => empty, :e6 => empty, :f6 => empty,
                    :g6 => empty, :h6 => empty,
                    
                    :a7 => empty, :b7 => empty, :c7 => empty, :d7 => empty, :e7 => empty, :f7 => empty,
                    :g7 => empty, :h7 => empty,
                    
                    :a8 => empty, :b8 => empty, :c8 => empty, :d8 => empty, :e8 => empty, :f8 => empty,
                    :g8 => empty, :h8 => empty}
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
      board.board = {:a1 => empty, :b1 => empty, :c1 => empty, :d1 => empty, :e1 => empty, :f1 => empty, 
                     :g1 => empty, :h1 => empty,
    
                     :a2 => empty, :b2 => empty, :c2 => empty, :d2 => empty, :e2 => empty, :f2 => empty, 
                     :g2 => empty, :h2 => empty,
    
                    :a3 => empty, :b3 => empty, :c3 => empty, :d3 => empty, :e3 => empty, :f3 => empty,
                    :g3 => empty, :h3 => empty,
    
                    :a4 => empty, :b4 => empty, :c4 => empty, :d4 => empty, :e4 => empty, :f4 => empty,
                    :g4 => empty, :h4 => empty,
    
                    :a5 => empty, :b5 => empty, :c5 => empty, :d5 => empty, :e5 => empty, :f5 => empty,
                    :g5 => empty, :h5 => empty,
    
                    :a6 => empty, :b6 => empty, :c6 => empty, :d6 => empty, :e6 => empty, :f6 => empty,
                    :g6 => empty, :h6 => empty,
                    
                    :a7 => empty, :b7 => empty, :c7 => empty, :d7 => empty, :e7 => empty, :f7 => empty,
                    :g7 => empty, :h7 => empty,
                    
                    :a8 => empty, :b8 => empty, :c8 => empty, :d8 => empty, :e8 => empty, :f8 => empty,
                    :g8 => empty, :h8 => empty}
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
      board.board = {:a1 => empty, :b1 => empty, :c1 => empty, :d1 => empty, :e1 => empty, :f1 => empty, 
                     :g1 => empty, :h1 => empty,
    
                     :a2 => empty, :b2 => empty, :c2 => empty, :d2 => empty, :e2 => empty, :f2 => empty, 
                     :g2 => empty, :h2 => empty,
    
                    :a3 => empty, :b3 => empty, :c3 => empty, :d3 => empty, :e3 => empty, :f3 => empty,
                    :g3 => empty, :h3 => empty,
    
                    :a4 => empty, :b4 => empty, :c4 => empty, :d4 => empty, :e4 => empty, :f4 => empty,
                    :g4 => empty, :h4 => empty,
    
                    :a5 => empty, :b5 => empty, :c5 => empty, :d5 => empty, :e5 => empty, :f5 => empty,
                    :g5 => empty, :h5 => empty,
    
                    :a6 => empty, :b6 => empty, :c6 => empty, :d6 => empty, :e6 => empty, :f6 => empty,
                    :g6 => empty, :h6 => empty,
                    
                    :a7 => empty, :b7 => empty, :c7 => empty, :d7 => empty, :e7 => empty, :f7 => empty,
                    :g7 => empty, :h7 => empty,
                    
                    :a8 => empty, :b8 => empty, :c8 => empty, :d8 => empty, :e8 => empty, :f8 => empty,
                    :g8 => empty, :h8 => empty}
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
      board.board = {:a1 => empty, :b1 => empty, :c1 => empty, :d1 => empty, :e1 => empty, :f1 => empty, 
                     :g1 => empty, :h1 => empty,
    
                     :a2 => empty, :b2 => empty, :c2 => empty, :d2 => empty, :e2 => empty, :f2 => empty, 
                     :g2 => empty, :h2 => empty,
    
                    :a3 => empty, :b3 => empty, :c3 => empty, :d3 => empty, :e3 => empty, :f3 => empty,
                    :g3 => empty, :h3 => empty,
    
                    :a4 => empty, :b4 => empty, :c4 => empty, :d4 => empty, :e4 => empty, :f4 => empty,
                    :g4 => empty, :h4 => empty,
    
                    :a5 => empty, :b5 => empty, :c5 => empty, :d5 => empty, :e5 => empty, :f5 => empty,
                    :g5 => empty, :h5 => empty,
    
                    :a6 => empty, :b6 => empty, :c6 => empty, :d6 => empty, :e6 => empty, :f6 => empty,
                    :g6 => empty, :h6 => empty,
                    
                    :a7 => empty, :b7 => empty, :c7 => empty, :d7 => empty, :e7 => empty, :f7 => empty,
                    :g7 => empty, :h7 => empty,
                    
                    :a8 => empty, :b8 => empty, :c8 => empty, :d8 => empty, :e8 => empty, :f8 => empty,
                    :g8 => empty, :h8 => empty}
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
