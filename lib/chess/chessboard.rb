module Chess
  class Chessboard
    include ChessHelper

    attr_accessor :moves
    attr_reader :board

    def initialize(input = {})
      @board = input.fetch(:board, default_board)
      @moves = 3
    end

    def move(from, to)
      valid_san = /^[a-hA-H][1-8]$/
      return false unless from != to && from.match(valid_san) && to.match(valid_san)
      @moves += 1
      piece = get_square(from)

      set_square(to, piece)
      piece.move_to(self, to)
      clear_square(from)
      set_square(to, Queen.new(color: piece.color, location: to)) if piece.to_be_promoted?
    end

    def get_square(san)
      x, y = get_xy(san)
      board[y][x]
    end

    def set_square(san, value)
      x, y = get_xy(san)
      board[y][x] = value
    end

    def get_squares(from, to)
      squares = []
      x_from, y_from = get_xy(from)
      x_to, y_to = get_xy(to)

      x_dir = direction(x_from, x_to)
      y_dir = direction(y_from, y_to)

      dx = distance(x_from, x_to)
      dy = distance(y_from, y_to)

      if same_square?(dx, dy)
        squares << board[y_from][x_from]
      elsif going_vertically?(dx, dy)
        (dy + 1).times { |i| squares << board[y_from + y_dir * i][x_from] }
      elsif going_horizontally?(dx, dy)
        (dx + 1).times { |i| squares << board[y_from][x_from + x_dir * i] }
      elsif going_diagonally?(dx, dy)
        (dy + 1).times { |i| squares << board[y_from + y_dir * i][x_from + x_dir * i] }
      end
      squares
    end

    def get_pieces(color)
      pieces = []
      board.each { |row| row.each { |square| pieces << square if square.is_a?(Piece) && square.color == color } }
      pieces
    end

    def path_blocked?(from, to)
      squares = get_squares(from, to)
      return false if squares.empty?
      squares[1..-2].any? { |square| square.is_a?(Piece) }
    end

    def going_vertically?(dx, dy)
      dx == 0 && dy > 0
    end

    def going_horizontally?(dx, dy)
      dx > 0 && dy == 0
    end

    def going_diagonally?(dx, dy)
      dx > 0 && dx == dy
    end

    private

    def clear_square(san)
      set_square(san, " ")
    end

    def same_square?(dx, dy)
      dx == 0 && dy == 0
    end

    def direction(from, to)
      from > to ? -1 : 1
    end

    def default_board
      board = Array.new(8) { Array.new(8) { " " } }

      board[0][0] = Rook.new(color: :white, location: "A1")
      board[0][1] = Knight.new(color: :white, location: "B1")
      board[0][2] = Bishop.new(color: :white, location: "C1")
      board[0][3] = Queen.new(color: :white, location: "D1")
      board[0][4] = King.new(color: :white, location: "E1")
      board[0][5] = Bishop.new(color: :white, location: "F1")
      board[0][6] = Knight.new(color: :white, location: "G1")
      board[0][7] = Rook.new(color: :white, location: "H1")

      board[1][0] = Pawn.new(color: :white, location: "A2")
      board[1][1] = Pawn.new(color: :white, location: "B2")
      board[1][2] = Pawn.new(color: :white, location: "C2")
      board[1][3] = Pawn.new(color: :white, location: "D2")
      board[1][4] = Pawn.new(color: :white, location: "E2")
      board[1][5] = Pawn.new(color: :white, location: "F2")
      board[1][6] = Pawn.new(color: :white, location: "G2")
      board[1][7] = Pawn.new(color: :white, location: "H2")

      board[6][0] = Pawn.new(color: :black, location: "A7")
      board[6][1] = Pawn.new(color: :black, location: "B7")
      board[6][2] = Pawn.new(color: :black, location: "C7")
      board[6][3] = Pawn.new(color: :black, location: "D7")
      board[6][4] = Pawn.new(color: :black, location: "E7")
      board[6][5] = Pawn.new(color: :black, location: "F7")
      board[6][6] = Pawn.new(color: :black, location: "G7")
      board[6][7] = Pawn.new(color: :black, location: "H7")

      board[7][0] = Rook.new(color: :black, location: "A8")
      board[7][1] = Knight.new(color: :black, location: "B8")
      board[7][2] = Bishop.new(color: :black, location: "C8")
      board[7][3] = Queen.new(color: :black, location: "D8")
      board[7][4] = King.new(color: :black, location: "E8")
      board[7][5] = Bishop.new(color: :black, location: "F8")
      board[7][6] = Knight.new(color: :black, location: "G8")
      board[7][7] = Rook.new(color: :black, location: "H8")

      board
    end
  end
end
