require_relative "../lib/game.rb"

RSpec.describe Knight do 
  describe "#team" do
    it "gives the corresponding color" do
      knight = WhiteKnight.new("e4")
      expect(knight.team).to eql("white")
      knight = BlackKnight.new("e4")
      expect(knight.team).to eql("black")
    end
  end
  describe "#show" do
    it "prints out the corresponding piece" do
      queen = WhiteKnight.new("e4")
      expect(queen.show).to eql("[♞]")
      queen = BlackKnight.new("e4")
      expect(queen.show).to eql("[♘]")
    end
  end
  describe "#next_move" do
    it "adds all potential moves to the @moves array" do
      board = Board.new
      empty = Empty.new

      board.board = board.board.each{ |key, value| board.board[key] = empty }

      knight = WhiteKnight.new("e4")
      knight.next_move("e4", board.board)
      expect(knight.moves).to eql(["f6", "g5", "g3", "f2", "d6", "c5", "c3", "d2"])
      knight = BlackKnight.new("e4")
      knight.next_move("e4", board.board)
      expect(knight.moves).to eql(["f6", "g5", "g3", "f2", "d6", "c5", "c3", "d2"])
    end
    it "allows attack on enemy piece" do
      board = Board.new

      board.board[:e4] = WhiteKnight.new("e4")
      white_knight = board.board[:e4]
      board.board[:f6] = BlackKnight.new("f6")
      black_knight = board.board[:f6]
      white_knight.next_move("e4", board.board)
      expect(white_knight.moves).to eql(["f6", "g5", "g3", "f2", "d6", "c5", "c3", "d2"])
      black_knight.next_move("f6", board.board)
      expect(black_knight.moves).to eql(["g8", "h7", "h5", "g4", "e8", "d7", "d5", "e4"])
    end
    it "backs up team piece" do
      board = Board.new

      board.board[:e3] = WhiteKnight.new("e3")
      white_knight = board.board[:e3]
      board.board[:f6] = BlackKnight.new("f6")
      black_knight = board.board[:f6]
      white_knight.next_move("e3", board.board)
      expect(white_knight.moves).to eql(["f5", "g4", "g2", "f1", "d5", "c4", "c2", "d1"])
      black_knight.next_move("f6", board.board)
      expect(black_knight.moves).to eql(["g8", "h7", "h5", "g4", "e8", "d7", "d5", "e4"])
    end

  end

end
