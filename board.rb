class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8) { NullPiece.new } }

    populate
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def populate
    #black pieces

    grid[1].each do |col|
      self[1, col] = Pawn.new(:P, :black [1, col])
    end

    self[0, 0] = Rook.new(:R, :black, [0,0])
    self[0, 7] = Rook.new(:R, :black, [0, 7])

    self[0, 1] = Knight.new(:Kn, :black, [0, 1])
    self[0, 6] = Knight.new(:Kn, :black, [0, 6])

    self[0, 2] = Bishop.new(:B, :black, [0, 2])
    self[0, 5] = Bishop.new(:B, :black, [0, 5])

    self[0, 3] = Queen.new(:Q, :black, [0, 3])
    self[0, 4] = King.new(:K, :black, [0, 4])

    #white pieces

    grid[6].each do |col|
      self[6, col] = Pawn.new(:P, :white [6, col])
    end

    self[7, 0] = Rook.new(:R, :white, [7, 0])
    self[7, 7] = Rook.new(:R, :white, [7, 7])

    self[7, 1] = Knight.new(:Kn, :white, [7, 1])
    self[7, 6] = Knight.new(:Kn, :white, [7, 6])

    self[7, 2] = Bishop.new(:B, :white, [7, 2])
    self[7, 5] = Bishop.new(:B, :white, [7, 5])

    self[7, 3] = Queen.new(:Q, :white, [7, 3])
    self[7, 4] = King.new(:K, :white, [7, 4])
  end

  def move(start, end_pos)
    piece_at_start?(start)
    update_board(start, end_pos)

  end



  private

  def piece_at_start?(pos)
    !self[pos].is_a?(NullPiece)
  end

  def update_board(start, end_pos)
    piece = board[start]
    valid_moves = valid?(piece.possible_moves)
    if valid_moves.include?(board[end_pos])
      self[end_pos] = piece
      piece.position = [end_pos]
      self[start] = NullPiece.new
    else
      raise "Invalid move"
    end
  end


end
