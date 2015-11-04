class Chess
  attr_reader :board, :display, :players

  def initialize(players, board = Board.new)
    @board = board
    @display = Display.new(@board)
    @players = players
  end

  def play
    until board.check_mate?(current_player.color)
      play_round
      switch_player!
    end
  end

  def play_round
    @selected = false
    @moved = false
    selected_pos = choose_piece
    move_piece(selected_pos)
    display.print_board
  end

  def current_player
    players[0]
  end

  def switch_player!
    players.rotate!
  end

  def choose_piece
    selected_pos = nil
    until @selected
      display.print_board

      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input) if board.on_board?(new_input)
      else
        selected_pos = display.cursor_pos
        @selected = true if board.valid_selection?(current_player.color, selected_pos)
      end
    end
    selected_pos
  end

  def move_piece(selected_pos)
    until @moved
      display.print_board(selected_pos)
      new_input = HumanPlayer.get_key(display.cursor_pos)

      if new_input
        display.update_cursor(new_input) if board.on_board?(new_input)
      else
        new_pos = display.cursor_pos
        if board.valid_move?(selected_pos, new_pos, current_player.color)
          @moved = true
          board.move_piece(selected_pos, new_pos)
        end
      end
    end
  end

  def inspect
    true
  end
end
