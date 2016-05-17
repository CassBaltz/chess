require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable
  attr_reader :board

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = false
  end

  def update_pos

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
  # def render
  #   puts
  #   @board.each_with_index do |row, r_idx|
  #     row.each_with_index do |square, sq_idx|
  #       piece = @board[r_idx][sq_idx]
  #
  #   puts
  #
  #
  # end



  # def draw_board
  #   @board.each_with_index do |row, r_idx|
  #     row.each_with_index do |square, sq_idx|
  #       if r_idx.even?
  #         if sq_idx.even?
  #           # color square light
  #         else
  #           # color square dark
  #         end
  #       else
  #         if sq_idx.even?
  #           # color square light
  #         else
  #           # color square dark
  #         end
  #       end
  #
  # end
end
