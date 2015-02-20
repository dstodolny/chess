# Chess

This is a final project for [The Odin Project](http://www.theodinproject.com/ruby-programming/ruby-final-project). Its a command-line chess clone written in TDD.

The game follows all of [the rules of chess](http://www.chessvariants.org/d.chess/chess.html).

To play the game run `bin/chess.rb` from the root directory. You can also run the test suite with `rake` from the same root directory.

## Chessboard

The game is played on a standard 8 by 8 chessboard. The initial chessboard is shown below:

```
 A B C D E F G H
8♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ 8
7♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟ 7
6                6
5                5
4                4
3                3
2♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙ 2
1♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ 1
 A B C D E F G H
```

The letters (A - H) and number (1 - 8) around the board are used to specify desired game moves.

## Game Moves

A move is entered as two positions separated by something or not. The following are valid ways to move a white pawn on the first game move:
* `A2 A3`
* `a2 a3`
* `A2 to A3`
* `A2, A3`
* `A2A3`

### Illegal moves

The game is designed to detect invalid moves. When a move is not valid the player will be asked to type another move.

After two valid board positions are detected, further checks are made.

### Special moves

All special moves in a chess game (castling, en passant, promotion, and a pawn's double step on its first move) are recognized and allowed during game play.

## Game Play

Game play alternates between two players as one would expect with only valid moves being allowed. Play continues until one of the kings is in checkmate.

## Game Saves

A player may save or load a game by typing `save` or `load` instead of moves.
