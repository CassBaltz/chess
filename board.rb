class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, piece)
    grid[row][col] = piece
  end

  def populate
    #black pieces
    
    grid[1].each do |col|
      self[1, col] = Pawn.new(:P, :black)
    end

    self[0, 0] = Rook.new(:R, :black)
    self[0, 7] = Rook.new(:R, :black)

    self[0, 1] = Knight.new(:Kn, :black)
    self[0, 6] = Knight.new(:Kn, :black)

    self[0, 2] = Bishop.new(:B, :black)
    self[0, 5] = Bishop.new(:B, :black)

    self[0, 3] = Queen.new(:Q, :black)
    self[0, 4] = King.new(:K, :black)

    #white pieces

    grid[6].each do |col|
      self[6, col] = Pawn.new(:P, :white)
    end

    self[7, 0] = Rook.new(:R, :white)
    self[7, 7] = Rook.new(:R, :white)

    self[7, 1] = Knight.new(:Kn, :white)
    self[7, 6] = Knight.new(:Kn, :white)

    self[7, 2] = Bishop.new(:B, :white)
    self[7, 5] = Bishop.new(:B, :white)

    self[7, 3] = Queen.new(:Q, :white)
    self[7, 4] = King.new(:K, :white)
  end

end
