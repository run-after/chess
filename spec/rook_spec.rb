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
end