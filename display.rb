require 'colorize'
require 'io/console'
require './player.rb'

class Display
  attr_reader :board, :cursor_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected_pos = nil
  end

  def print_out
    while true
      print_board
      new_pos = HumanPlayer.get_key(@cursor_pos)
      break unless new_pos
      @cursor_pos = new_pos if board.on_board?(new_pos)
    end
  end

  def update_cursor(new_pos)
    @cursor_pos = new_pos
  end

  def print_board(selected_pos = nil)
    print_str = ''

    highlight_center = selected_pos || @cursor_pos
    @valid_moves = board.valid_moves(board[highlight_center].color, highlight_center)
    system 'clear'
    board.grid.each_with_index do |row, row_i|
      print_str << print_row(row, row_i, highlight_center)
    end
    print print_str
    true
  end

  def print_row(row, row_i, selected_pos)
    print_str = ''

    row.each_with_index do |el, cell_i|
      print_str <<
      if @cursor_pos == [row_i, cell_i]
        el.to_s.colorize( :background => :blue)
      elsif @valid_moves.include?([row_i, cell_i])
        el.to_s.colorize( :background => :yellow)
      elsif selected_pos == [row_i, cell_i]
        el.to_s.colorize( :background => :cyan)
      elsif (row_i + cell_i).even?
        el.to_s.colorize( :background => :light_black)
      else
        el.to_s.colorize( :background => :light_white)
      end
    end
    print_str + "\n"
  end
end
