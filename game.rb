require "pry"
require "./bishop.rb"
require "./board.rb"
require "./empty.rb"
require "./king.rb"
require "./knight.rb"
require "./pawn.rb"
require "./queen.rb"
require "./rook.rb"

class Game
  attr_reader :round, :board
  def initialize
    @round = 1
    @board = Board.new
    @board.draw
  end

end

