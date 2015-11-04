require 'colorize'
require 'io/console'
require_relative './game/board'
require_relative './game/player'
require_relative './game/display'
require_relative './game/chess'


if $PROGRAM_NAME == __FILE__
  board = Board.new
  player1 = HumanPlayer.new(:red)
  player2 = HumanPlayer.new(:black)
  players = [player1, player2]

  game = Chess.new(players, board)

  game.play
end