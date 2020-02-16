require_relative "../lib/game.rb"

RSpec.describe Board do 
  describe "#initialize" do
    it "creates a new board with all pieces on move 1" do
      board = Board.new
      expect(board.board[:e2].is_a?(WhitePawn)).to eql(true)
      expect(board.board[:e8].is_a?(BlackKing)).to eql(true)
      expect(board.board[:h1].is_a?(WhiteRook)).to eql(true)
      expect(board.board[:c8].is_a?(BlackBishop)).to eql(true)
    end
  end
  describe "#draw" do
    it "draws out a chess board with all pieces on move 1" do
      board = Board.new
      expect{board.draw}.to output(
"[♖][♘][♗][♕][♔][♗][♘][♖]8
[♙][♙][♙][♙][♙][♙][♙][♙]7
[ ][ ][ ][ ][ ][ ][ ][ ]6
[ ][ ][ ][ ][ ][ ][ ][ ]5
[ ][ ][ ][ ][ ][ ][ ][ ]4
[ ][ ][ ][ ][ ][ ][ ][ ]3
[♟][♟][♟][♟][♟][♟][♟][♟]2
[♜][♞][♝][♛][♚][♝][♞][♜]1
 a  b  c  d  e  f  g  h\n").to_stdout
    end
  end
end