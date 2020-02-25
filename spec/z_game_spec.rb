require_relative "../lib/game.rb"

RSpec.describe Game do 
  describe "#play_round" do
    #it "goes through a game and declares winner" do
    #  game = Game.new
    #  expect(game).to receive(:gets).and_return("e2", "e4", "f7", "f6", "a2", "a3",
    #                                            "g7", "g5", "d1", "h5")
    #  game.play_round
    #  expect(game.checkmate?("black")).to eql(true)

    #end
    it "goes through a game and declares winner" do
      game = Game.new
      expect(game).to receive(:gets).and_return("e2", "e4", "e7", "e5", "d2", "d4",
      "e5", "d4", "g1", "f3", "g8", "f6", "f1", "c4", "d7", "d5", "e4", "d5", "c7",
      "c5", "c1", "g5", "f8", "e7", "d1", "e2", "e8", "h8", "f3", "e5", "f6", "d5", 
      "g5", "e7", "d5", "e7", "e5", "f7", "f8", "f7", "e2", "h5", "d8", "e8", "e1",
      "h1", "b7", "b6", "f2", "f4", "c8", "f5", "g2", "g4", "f5", "c2", "g4", "g5",
      "g7", "g6", "c4", "f7", "e8", "f7", "h5", "f3", "b8", "c6", "b1", "d2", "a8",
      "f8", "d2", "c4", "f7", "c4", "f1", "c1", "d4", "d3", "b2", "b3", "c4", "f4",
      "f3", "f4", "f8", "f4", "a2", "a4", "c6", "d4", "c1", "f1", "f4", "f1", "a1", 
      "f1", "d3", "d2", "g1", "g2", "e7", "f5", "f1", "g1", "d2", "d1", "1", "g1", 
      "d1", "c2", "d1", "g2", "h3", "d1", "b3", "h3", "g4", "c5", "c4", "h2", "h4",
      "c4", "c3", "h4", "h5", "c3", "c2", "a4", "a5", "b6", "a5", "h5", "g6", "h7",
      "g6", "g4", "f4", "c2", "c1", "1", "f4", "e5", "c1", "e3", "e5", "f6", "e3", "e6")

      game.play_round
      expect(game.checkmate?("white")).to eql(true)

    end
  end
end