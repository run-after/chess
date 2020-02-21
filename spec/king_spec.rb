require_relative "../lib/game.rb"

RSpec.describe King do 
  describe "#team" do
    it "gives the corresponding color" do
      expect(WhiteKing.new("e4").team).to eql("white")
      expect(BlackKing.new("e4").team).to eql("black")
    end
  end
  describe "#show" do
    it "prints out the corresponding piece" do
      expect(WhiteKing.new("e4").show).to eql("[♚]")
      expect(BlackKing.new("e4").show).to eql("[♔]")
    end
  end
  describe "#next_move" do
    it "adds all potential moves to the @moves array" do
      board = Board.new

      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }

      king = WhiteKing.new("e4")
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["e5", "f5", "f4", "f3", "e3", "d3", "d4", "d5"])
      king = BlackKing.new("e4")
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["e5", "f5", "f4", "f3", "e3", "d3", "d4", "d5"])
    end
    it "won't allow king to move into check" do
      board = Board.new

      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }

      king = WhiteKing.new("e4")
      board.board[:h5] = BlackRook.new("h5", board.board)
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["f4", "f3", "e3", "d3", "d4"])
      king = BlackKing.new("e4")
      board.board[:h5] = WhiteRook.new("h5", board.board)
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["f4", "f3", "e3", "d3", "d4"])
    end
    it "allows attack on enemy piece" do
      board = Board.new
      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }
      board.board[:e5] = BlackKnight.new("e5", board.board)

      king = WhiteKing.new("e4")
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["e5", "f5", "f4", "e3", "d4", "d5"])

      board.board[:e5] = WhiteKnight.new("e5", board.board)
      king = BlackKing.new("e4")
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["e5", "f5", "f4", "e3", "d4", "d5"])
    end
    it "allows king side castling" do
      game = Game.new
      game.board.board = game.board.board.each{ |key, value| game.board.board[key] = Empty.new }
      game.board.board[:e1] = WhiteKing.new("e1", game.board.board)
      game.board.board[:h1] = WhiteRook.new("h1", game.board.board) 
      game.update
      game.castle("e1", "h1")
      expect(game.board.board[:f1].is_a?(WhiteRook)).to eql(true)

      game.board.board = game.board.board.each{ |key, value| game.board.board[key] = Empty.new }
      game.board.board[:e8] = BlackKing.new("e8", game.board.board)
      game.board.board[:h8] = BlackRook.new("h8", game.board.board)
      game.update
      game.castle("e8", "h8")
      expect(game.board.board[:f8].is_a?(BlackRook)).to eql(true)
    end
    it "allows queen side castling" do
      game = Game.new
      game.board.board = game.board.board.each{ |key, value| game.board.board[key] = Empty.new }
      game.board.board[:e1] = WhiteKing.new("e1", game.board.board)
      game.board.board[:a1] = WhiteRook.new("a1", game.board.board) 
      game.update
      game.castle("e1", "a1")
      expect(game.board.board[:d1].is_a?(WhiteRook)).to eql(true)

      game.board.board = game.board.board.each{ |key, value| game.board.board[key] = Empty.new }
      game.board.board[:e8] = BlackKing.new("e8", game.board.board)
      game.board.board[:a8] = BlackRook.new("a8", game.board.board)
      game.update
      game.castle("e8", "a8")
      expect(game.board.board[:d8].is_a?(BlackRook)).to eql(true)
    end
    it "doesn't allow castling if moving through a check" do
      game = Game.new
      game.board.board = game.board.board.each{ |key, value| game.board.board[key] = Empty.new }
      game.board.board[:e1] = WhiteKing.new("e1", game.board.board)
      game.board.board[:a1] = WhiteRook.new("a1", game.board.board)
      game.board.board[:b8] = BlackRook.new("d8", game.board.board)
      game.update
      game.castle("e1", "a1")
      expect(game.board.board[:d1].is_a?(WhiteRook)).to eql(false)
    end
    it "doesn't allow castling if either king or rook has moved" do
      game = Game.new
      game.board.board = game.board.board.each{ |key, value| game.board.board[key] = Empty.new }
      game.board.board[:e1] = WhiteKing.new("e1", game.board.board)
      game.board.board[:e1].first_move = false
      game.board.board[:a1] = WhiteRook.new("a1", game.board.board)
      game.update
      game.castle("e1", "a1")
      expect(game.board.board[:d1].is_a?(WhiteRook)).to eql(false)
    end
    it "backs up team piece" do
      board = Board.new
      board.board = board.board.each{ |key, value| board.board[key] = Empty.new }
      board.board[:e5] = WhiteKnight.new("e5", board.board)

      king = WhiteKing.new("e4")
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["e5", "f5", "f4", "f3", "e3", "d3", "d4", "d5"])

      board.board[:e5] = BlackKnight.new("e5", board.board)
      king = BlackKing.new("e4")
      king.next_move("e4", board.board)
      expect(king.moves).to eql(["e5", "f5", "f4", "f3", "e3", "d3", "d4", "d5"])
    end
  end

end
