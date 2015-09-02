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

  def update_cursor(new_pos)
    @cursor_pos = new_pos
  end

  def print_board(selected_pos = nil)
    print_str = ''

    if selected_pos
      highlight_center = selected_pos
      @valid_moves = board.valid_moves(board[highlight_center].color, highlight_center)
      
      board.grid.each_with_index do |row, row_i|
        print_str << print_row(row, row_i, highlight_center)
      end
    else
      highlight_center = @cursor_pos

      board.grid.each_with_index do |row, row_i|
        @valid_moves = []
        print_str << print_row(row, row_i, highlight_center)
      end
    end

    system 'clear'
    print print_str
    true
  end

  def print_row(row, row_i, selected_pos = nil)
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
