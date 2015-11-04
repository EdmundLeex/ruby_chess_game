require 'colorize'
require 'io/console'
require_relative './board'
require_relative './player'
require_relative './display'
require_relative './chess'


if $PROGRAM_NAME == __FILE__
  board = Board.new
  player1 = HumanPlayer.new(:red)
  player2 = HumanPlayer.new(:black)
  players = [player1, player2]

  game = Chess.new(players, board)

  game.play
end