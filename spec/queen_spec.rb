require_relative "../lib/game.rb"

RSpec.describe Queen do 
  describe "#team" do
    it "gives the corresponding color" do
      queen = WhiteQueen.new("e4")
      expect(queen.team).to eql("white")
      queen = BlackQueen.new("e4")
      expect(queen.team).to eql("black")
    end
  end
  describe "#show" do
    it "prints out the corresponding piece" do
      queen = WhiteQueen.new("e4")
      expect(queen.show).to eql("[♛]")
      queen = BlackQueen.new("e4")
      expect(queen.show).to eql("[♕]")
    end
  end
  describe "#next_move" do
    it "adds all potential moves to the @moves array" do
      board = Board.new
      empty = Empty.new

      board.board = board.board.each{ |key, value| board.board[key] = empty }

      queen = WhiteQueen.new("e4")
      queen.next_move("e4", board.board)
      expect(queen.moves).to eql(["f5", "g6", "h7", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1",
                                  "f4", "g4", "h4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
      queen = BlackQueen.new("e4")
      queen.next_move("e4", board.board)
      expect(queen.moves).to eql(["f5", "g6", "h7", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1",
                                  "f4", "g4", "h4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
    end
    it "makes the last move available the opponent if in line with moves" do
      board = Board.new
      empty = Empty.new

      board.board = board.board.each{ |key, value| board.board[key] = empty }

      board.board[:e4] = WhiteQueen.new("e4")
      white_queen = board.board[:e4]
      board.board[:f4] = BlackQueen.new("f4")
      black_queen = board.board[:f4]
      white_queen.next_move("e4", board.board)
      expect(white_queen.moves).to eql(["f5", "g6", "h7", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1",
                                        "f4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
      black_queen.next_move("f4", board.board)
      expect(black_queen.moves).to eql(["g5", "h6", "g3", "h2", "e5", "d6", "c7", "b8", "e3", "d2", "c1", "g4", "h4",
                                        "e4", "f5", "f6", "f7", "f8", "f3", "f2", "f1"])
    end
    it "makes the last move available the team space if in line with moves" do
      board = Board.new
      empty = Empty.new
      
      board.board = board.board.each{ |key, value| board.board[key] = empty }
      
      board.board[:e4] = WhiteQueen.new("e4")
      white_queen = board.board[:e4]
      board.board[:f4] = WhiteQueen.new("f4")
      black_queen = board.board[:f4]
      white_queen.next_move("e4", board.board)
      expect(white_queen.moves).to eql(["f5", "g6", "h7", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1",
                                        "f4", "d4", "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
      black_queen.next_move("f4", board.board)
      expect(black_queen.moves).to eql(["g5", "h6", "g3", "h2", "e5", "d6", "c7", "b8", "e3", "d2", "c1", "g4", "h4",
                                        "e4", "f5", "f6", "f7", "f8", "f3", "f2", "f1"])
    end
    it "doesn't allow king to move inline with a check i.e. it says queen has available moves through king" do
      board = Board.new
      empty = Empty.new

      board.board = board.board.each{ |key, value| board.board[key] = empty }
      
      board.board[:e4] = WhiteQueen.new("e4")
      white_queen = board.board[:e4]
      board.board[:f4] = BlackQueen.new("f4")
      black_queen = board.board[:f4]
      board.board[:f5] = WhiteKing.new("f5")
      board.board[:e3] = BlackKing.new("e3")
      white_queen.next_move("e4", board.board)
      expect(white_queen.moves).to eql(["f5", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1", "f4", "d4", 
                                        "c4", "b4", "a4", "e5", "e6", "e7", "e8", "e3", "e2", "e1"])
      black_queen.next_move("f4", board.board)
      expect(black_queen.moves).to eql(["g5", "h6", "g3", "h2", "e5", "d6", "c7", "b8", "e3", "g4", "h4", "e4", "f5", 
                                        "f6", "f7", "f8", "f3", "f2", "f1"])
    end

  end

end
