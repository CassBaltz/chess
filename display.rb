require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable
  include Colorize
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = false
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg, color: :white }
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end

  def select_piece
    until @selected && piece_at_start?(@cursor_pos)
      @selected = false
      @cursor_pos = get_input
      render
    end
    @selected_piece = board.grid[@cursor_pos[0]][@cursor_pos[1]]
    board.grid[@cursor_pos[0]][@cursor_pos[1]] = NullPiece.instance
  end

  def move_piece
    possible_moves = @selected_piece.moves
    p "possible moves: "
    p possible_moves
    until @selected == false
      @selected = true
      @cursor_pos = get_input
      render
      unless possible_moves.include?(@cursor_pos)
        @selected = true
      end
    end
    board.grid[@cursor_pos[0]][@cursor_pos[1]] = @selected_piece
    if @selected_piece.is_a?(Pawn)
      unless @selected_piece.position == [@cursor_pos[0], @cursor_pos[1]]
        @selected_piece.first_move = false
      end
    end
    @selected_piece.position = [@cursor_pos[0], @cursor_pos[1]]
    render
  end

  def piece_at_start?(pos)
    x, y = pos
    !board[x, y].is_a?(NullPiece)
  end
end
