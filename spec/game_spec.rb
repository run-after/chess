RSpec.describe Game do
  describe "#initialize" do
    it "creates a new board, sets 'round' to 1 and draws board" do
      game = Game.new
      expect(game.round).to eql(1)
    end
  end
end