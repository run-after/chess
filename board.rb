class Board
  attr_accessor :board
                
  def initialize
    empty = Empty.new
    @board = {:a1 => WhiteRook.new("a1"), :b1 => WhiteKnight.new("b1"), :c1 => WhiteBishop.new("c1"), 
              :d1 => WhiteQueen.new("d1"), :e1 => WhiteKing.new("e1"), :f1 => WhiteBishop.new("f1"), 
              :g1 => WhiteKnight.new("g1"), :h1 => WhiteRook.new("h1"),
    
              :a2 => WhitePawn.new("a2"), :b2 => WhitePawn.new("b2"), :c2 => WhitePawn.new("c2"), 
              :d2 => WhitePawn.new("d2"), :e2 => WhitePawn.new("e2"), :f2 => WhitePawn.new("f2"), 
              :g2 => WhitePawn.new("g2"), :h2 => WhitePawn.new("h2"),
    
              :a3 => empty, :b3 => empty, :c3 => empty, :d3 => empty, :e3 => empty, :f3 => empty,
              :g3 => empty, :h3 => empty,
    
              :a4 => empty, :b4 => empty, :c4 => empty, :d4 => empty, :e4 => empty, :f4 => empty,
              :g4 => empty, :h4 => empty,
    
              :a5 => empty, :b5 => empty, :c5 => empty, :d5 => empty, :e5 => empty, :f5 => empty,
              :g5 => empty, :h5 => empty,
    
              :a6 => empty, :b6 => empty, :c6 => empty, :d6 => empty, :e6 => empty, :f6 => empty,
              :g6 => empty, :h6 => empty,

              :a7 => BlackPawn.new("a7"), :b7 => BlackPawn.new("b7"), :c7 => BlackPawn.new("c7"),
              :d7 => BlackPawn.new("d7"), :e7 => BlackPawn.new("e7"), :f7 => BlackPawn.new("f7"),
              :g7 => BlackPawn.new("g7"), :h7 => BlackPawn.new("h7"),

              :a8 => BlackRook.new("a8"), :b8 => BlackKnight.new("b8"), :c8 => BlackBishop.new("c8"),
              :d8 => BlackQueen.new("d8"), :e8 => BlackKing.new("e8"),  :f8 => BlackBishop.new("f8"),
              :g8 => BlackKnight.new("g8"), :h8 => BlackRook.new("h8")}
  end

  def draw
    print "#{board[:a8].show}#{board[:b8].show}#{board[:c8].show}#{board[:d8].show}#{board[:e8].show}"
    print "#{board[:f8].show}#{board[:g8].show}#{board[:h8].show}8"
    puts
    print "#{board[:a7].show}#{board[:b7].show}#{board[:c7].show}#{board[:d7].show}#{board[:e7].show}"
    print "#{board[:f7].show}#{board[:g7].show}#{board[:h7].show}7"
    puts
    print "#{board[:a6].show}#{board[:b6].show}#{board[:c6].show}#{board[:d6].show}#{board[:e6].show}"
    print "#{board[:f6].show}#{board[:g6].show}#{board[:h6].show}6"
    puts
    print "#{board[:a5].show}#{board[:b5].show}#{board[:c5].show}#{board[:d5].show}#{board[:e5].show}"
    print "#{board[:f5].show}#{board[:g5].show}#{board[:h5].show}5"
    puts
    print "#{board[:a4].show}#{board[:b4].show}#{board[:c4].show}#{board[:d4].show}#{board[:e4].show}"
    print "#{board[:f4].show}#{board[:g4].show}#{board[:h4].show}4"
    puts
    print "#{board[:a3].show}#{board[:b3].show}#{board[:c3].show}#{board[:d3].show}#{board[:e3].show}"
    print "#{board[:f3].show}#{board[:g3].show}#{board[:h3].show}3"
    puts
    print "#{board[:a2].show}#{board[:b2].show}#{board[:c2].show}#{board[:d2].show}#{board[:e2].show}"
    print "#{board[:f2].show}#{board[:g2].show}#{board[:h2].show}2"
    puts
    print "#{board[:a1].show}#{board[:b1].show}#{board[:c1].show}#{board[:d1].show}#{board[:e1].show}"
    print "#{board[:f1].show}#{board[:g1].show}#{board[:h1].show}1"
    puts 
    puts " a  b  c  d  e  f  g  h"

  end

end
