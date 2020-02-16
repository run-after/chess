require_relative "./lib/board"
require_relative "./lib/empty"
require_relative "./lib/rook"
require_relative "./lib/knight"
require_relative "./lib/bishop"
require_relative "./lib/queen"
require_relative "./lib/king"
require_relative "./lib/pawn"
require_relative "./lib/piece"


RSpec.describe Board do 
  #describe "#draw" do
  #  it "draws out a chess board with all pieces on move 1" do
  #    board = Board.new
  #    expect(board.draw).to 
  #  end
  #end
  describe "#initialize" do
    it "creates a new board with all pieces on move 1" do
      board = Board.new
      expect(board.board[:e2].is_a?(WhitePawn)).to eql(true)
    end
  end
end