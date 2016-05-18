require_relative 'display'
require_relative 'piece'
require_relative 'cursorable'

class Board
  attr_reader :grid, :display

  def initialize
    @grid = Array.new(8) {Array.new(8) { NullPiece.instance } }
    populate
    @display = Display.new(self)
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, piece)
    grid[row][col] = piece
  end

  def rows
    @grid
  end

  def populate
    #black pieces

    grid[1].each_with_index do |col, colidx|
      self[1, colidx] = Pawn.new(' ♟ ', :black, [1, colidx], self)
    end

    self[0, 0] = Rook.new(' ♜ ', :black, [0, 0], self)
    self[0, 7] = Rook.new(' ♜' , :black, [0, 7], self)

    self[0, 1] = Knight.new(' ♞ ', :black, [0, 1], self)
    self[0, 6] = Knight.new(' ♞ ', :black, [0, 6], self)

    self[0, 2] = Bishop.new(' ♝ ', :black, [0, 2], self)
    self[0, 5] = Bishop.new(' ♝ ', :black, [0, 5], self)

    self[0, 3] = Queen.new(' ♛ ', :black, [0, 3], self)
    self[0, 4] = King.new(' ♚ ', :black, [0, 4], self)

    #white pieces

    grid[6].each_with_index do |col, colidx|
      self[6, colidx] = Pawn.new(' ♙ ', :white, [6, colidx], self)
    end

    self[7, 0] = Rook.new(' ♖ ', :white, [7, 0], self)
    self[7, 7] = Rook.new(' ♖ ', :white, [7, 7], self)

    self[7, 1] = Knight.new(' ♘ ', :white, [7, 1], self)
    self[7, 6] = Knight.new(' ♘ ', :white, [7, 6], self)

    self[7, 2] = Bishop.new(' ♗ ', :white, [7, 2], self)
    self[7, 5] = Bishop.new(' ♗ ', :white, [7, 5], self)

    self[7, 3] = Queen.new(' ♕ ', :white, [7, 3], self)
    self[7, 4] = King.new(' ♔ ', :white, [7, 4], self)
  end

  def play
    until check_mate?
      play_move
    end
  end

  def play_move
    display.render
    display.select_piece
    display.move_piece
  end

  def in_bounds?(new_pos)
    x, y = new_pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def in_check?

  end

  def check_mate?

  end



  # private
  #
  # def update_board(start, end_pos)
  #   piece = board[start]
  #   valid_moves = valid?(piece, end_pos)
  #   if valid_moves.include?(board[end_pos])
  #     self[end_pos] = piece
  #     piece.position = [end_pos]
  #     self[start] = NullPiece.new
  #   else
  #     raise "Invalid move"
  #   end
  # end
  #

end

a = Board.new
a.play
