require 'singleton'
require 'byebug'


class Piece

  attr_reader :symbol, :color, :board
  attr_accessor :position
  def initialize(symbol, color, position, board)
    @symbol = symbol
    @color = color
    @position = position
    @board = board
  end

  def moves
  end

  def valid_move?(pos, color)
    x, y = pos

    return false unless x.between?(0, 7) && y.between?(0, 7)

    if color == board[x, y].color
      return false
    elsif board[x, y].color.nil?
      return true
    else
      @continue = false
      return true
    end
  end


  def to_s
    @symbol.encode('utf-8')
  end

end

class NullPiece
  include Singleton

  attr_reader :symbol, :color, :position, :board

  def initialize
    @symbol = nil
    @color = nil
    @position = nil
    @board = nil
  end

  def to_s
    "   "
  end

end

class SlidingPiece < Piece
  def initialize(symbol, color, position, board)
    super
  end

  def moves
    possible_moves = [self.position]
    deltas = self.deltas

    deltas.each do |delta|
      @continue = true
      curr_pos = self.position
      while @continue #until hit a white piece / take a black piece
        x = curr_pos[0] + delta[0]
        y = curr_pos[1] + delta[1]

        if valid_move?([x, y], self.color)
          possible_moves << [x, y]
          curr_pos = [x, y]
        else
          break
        end
      end
    end
    possible_moves
  end
end

class SteppingPiece < Piece
  def initialize(symbol, color, position, board)
    super
  end

  def moves
    possible_moves = [self.position]
    deltas = self.deltas

    deltas.each do |delta|
      curr_pos = self.position
      x = curr_pos[0] + delta[0]
      y = curr_pos[1] + delta[1]
      if valid_move?([x, y], self.color)
        possible_moves << [x, y]
      end
    end
    possible_moves
  end
end

class Pawn < SteppingPiece
  attr_accessor :first_move
  def initialize(symbol, color, position, board)
    super
    @first_move = true
  end

  def moves
    possible_moves = [self.position]

    curr_pos = self.position

    case self.color
    when :black
      one_in_front = [curr_pos[0] + 1, curr_pos[1]]
      two_in_front = [curr_pos[0] + 2, curr_pos[1]]
      diag_left = [curr_pos[0] + 1, curr_pos[1] + 1]
      diag_right = [curr_pos[0] + 1, curr_pos[1] - 1]
    when :white
      one_in_front = [curr_pos[0] - 1, curr_pos[1]]
      two_in_front = [curr_pos[0] - 2, curr_pos[1]]
      diag_left = [curr_pos[0] - 1, curr_pos[1] + 1]
      diag_right = [curr_pos[0] - 1, curr_pos[1] - 1]
    end
    possible_moves << one_in_front if board[one_in_front[0], one_in_front[1]].is_a?(NullPiece)

    if first_move && (board[one_in_front[0], one_in_front[1]].is_a?(NullPiece) && board[two_in_front[0], two_in_front[1]].is_a?(NullPiece))
      possible_moves << two_in_front
    end
    if board[diag_left[0], diag_left[1]].color != @color && board[diag_left[0], diag_left[1]].color != nil
      possible_moves << diag_left
    end
    if board[diag_right[0], diag_right[1]].color != @color && board[diag_right[0], diag_right[1]].color != nil
      possible_moves << diag_right
    end

    possible_moves.keep_if {|pair| pair[0].between?(0, 7) && pair[1].between?(0, 7)}
  end
end

class Rook < SlidingPiece

  def initialize(symbol, color, position, board)
    super
  end

  def deltas
    @deltas = [[0, 1], [1, 0], [-1, 0], [0, -1]]
  end
end

class Knight < SteppingPiece
  def initialize(symbol, color, position, board)
    super
  end

  def deltas
    @deltas = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  end
end

class Bishop < SlidingPiece
  def initialize(symbol, color, position, board)
    super
  end

  def deltas
    @deltas = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end
end

class Queen < SlidingPiece
  def initialize(symbol, color, position, board)
    super
  end

  def deltas
    @deltas = [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, -1], [-1, 1]]
  end
end

class King < SteppingPiece
  def initialize(symbol, color, position, board)
    super
  end

  def deltas
    @deltas = [[0, 1], [1, 0], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, -1], [-1, 1]]
  end
end
#
# load 'board.rb';
# b = Board.new;
# king = King.new("K", :black, [2, 2], b);
# b[2, 2] = king;
# king.moves
