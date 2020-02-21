require_relative "../lib/game.rb"

RSpec.describe Bishop do 
  describe "#team" do
    it "gives the corresponding color" do
      expect(WhiteBishop.new("e4").team).to eql("white")
      expect(BlackBishop.new("e4").team).to eql("black")
    end
  end
  describe "#show" do
    it "prints out the corresponding piece" do
      expect(WhiteBishop.new("e4").show).to eql("[♝]")
      expect(BlackBishop.new("e4").show).to eql("[♗]")
    end
  end
  describe "#next_move" do
    it "adds all potential moves to the @moves array" do
      board = Board.new
      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }

      bishop = WhiteBishop.new("e4")
      bishop.next_move("e4", board.board)
      expect(bishop.moves).to eql(["f5", "g6", "h7", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1"])
      bishop = BlackBishop.new("e4")
      bishop.next_move("e4", board.board)
      expect(bishop.moves).to eql(["f5", "g6", "h7", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1"])
    end
    it "backs up team piece" do
      board = Board.new
      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }
      board.board[:f5] = WhitePawn.new("f5")
      bishop = WhiteBishop.new("e4")
      bishop.next_move("e4", board.board)
      expect(bishop.moves).to eql(["f5", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1"])
      
      board.board[:f5] = BlackPawn.new("f5")
      bishop = BlackBishop.new("e4")
      bishop.next_move("e4", board.board)
      expect(bishop.moves).to eql(["f5", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1"])
    end
    it "attacks enemy piece" do
      board = Board.new
      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }
      board.board[:f5] = BlackPawn.new("f5")
      bishop = WhiteBishop.new("e4")
      bishop.next_move("e4", board.board)
      expect(bishop.moves).to eql(["f5", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1"])
      
      board.board[:f5] = WhitePawn.new("f5")
      bishop = BlackBishop.new("e4")
      bishop.next_move("e4", board.board)
      expect(bishop.moves).to eql(["f5", "f3", "g2", "h1", "d5", "c6", "b7", "a8", "d3", "c2", "b1"])
    end
  end
end