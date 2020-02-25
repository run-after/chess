require_relative "../lib/game.rb"
require "pry"
RSpec.describe Pawn do 
  describe "#team" do
    it "gives the corresponding color" do
      pawn = WhitePawn.new("e4")
      expect(pawn.team).to eql("white")
      pawn = BlackPawn.new("e4")
      expect(pawn.team).to eql("black")
    end
  end
  describe "#show" do
  it "prints out the corresponding piece" do
    pawn = WhitePawn.new("e4")
    expect(pawn.show).to eql("[♟]")
    pawn = BlackPawn.new("e4")
    expect(pawn.show).to eql("[♙]")
  end
end
  describe "#next_move" do
    it "allows first move to be 1 ahead, or 2 ahead" do
      board = Board.new
      expect(board.board[:e2].moves).to eql(["e4", "e3"])
      expect(board.board[:e7].moves).to eql(["e5", "e6"])
    end
    it "allows diagonal attack if enemy piece is there" do
      board = Board.new
      board.board[:f6] = WhitePawn.new("f6")
      board.board[:e7].next_move("e7", board.board)
      board.board[:f3] = BlackPawn.new("f3")
      board.board[:e2].next_move("e2", board.board)
      expect(board.board[:e2].moves).to eql(["e3", "e4", "f3"])
      expect(board.board[:e7].moves).to eql(["e6", "e5", "f6"])
    end
    it "backs up team piece" do
    board = Board.new
      board.board[:f6] = BlackPawn.new("f6")
      board.board[:e7].next_move("e7", board.board)
      board.board[:f3] = WhitePawn.new("f3")
      board.board[:e2].next_move("e2", board.board)
      expect(board.board[:e2].moves).to eql(["e3", "e4", "f3"])
      expect(board.board[:e7].moves).to eql(["e6", "e5", "f6"])
    end
    it "allows en passant" do
      game = Game.new
      game.board.board[:f4] = BlackPawn.new("f4")
      game.move("e2", "e4")
      game.board.board[:e4].en_passantable = true
      game.board.board[:f4].next_move("f4", game.board.board)
      expect(game.board.board[:f4].moves.include?("e3")).to eql(true)

      game.board.board[:f5] = WhitePawn.new("f5")
      game.move("e7", "e5")
      game.board.board[:e5].en_passantable = true
      game.board.board[:f5].next_move("f5", game.board.board)
      expect(game.board.board[:f5].moves.include?("e6")).to eql(true)
    end
    it "disallows double move if piece has been moved" do
      game = Game.new
      game.move("e2", "e3")
      game.move("e7", "e6")
      game.update
      expect(game.board.board[:e3].moves).to eql(["e4"])
      expect(game.board.board[:e6].moves).to eql(["e5"])
    end
    it "promotes pawn that makes it to the last rank" do
      board = Board.new
      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }
     
      expect_any_instance_of(Pawn).to receive(:gets).and_return("1")
      white_pawn = WhitePawn.new("a8", board.board)
      white_pawn.next_move("a8", board.board)
      expect(board.board[:a8].is_a?(WhiteQueen)).to eql(true)
    end
  end
end