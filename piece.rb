class Piece

  attr_reader :symbol, :color, :position
  def initialize(symbol, color)
    @symbol = symbol
    @color = color
    @position = position
  end
end

class NullPiece
end

class SlidingPiece < Piece
  def initialize
    super
  end
end

class SteppingPiece < Piece
  def initialize
    super
  end
end

class Pawn < Piece
  def initialize
    super
  end
end

class Rook < SlidingPiece
  def initialize
    super
  end
end

class Knight < SteppingPiece
  def initialize
    super
  end
end

class Bishop < SlidingPiece
  def initialize
    super
  end
end

class Queen < SlidingPiece
  def initialize
    super
  end
end

class King < SteppingPiece
  def initialize
    super
  end
end
