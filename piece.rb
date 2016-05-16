class Piece
  def initialize(name, color, symbol)
    @symbol = symbol
    @name = name
    @color = color
  end
end

class Pawn < Piece
  def initialize
    super
  end
end
