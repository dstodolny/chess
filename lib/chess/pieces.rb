module Chess
  class Piece
    include ChessHelper

    attr_accessor :location
    attr_reader :color

    def initialize(input = {})
      @color = input.fetch(:color, :white)
      @location = input.fetch(:location, "A1")
    end

    def valid_move?(chessboard, to)
      if to == location
        return false
      elsif friend?(chessboard.get_square(to))
        return false
      elsif chessboard.path_blocked?(location, to)
        return false
      else
        return true
      end
    end

    def friend?(piece)
      piece.color == color if piece.is_a?(Piece)
    end

    def enemy?(piece)
      piece.color != color if piece.is_a?(Piece)
    end
  end

  class Pawn < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)
      destination = chessboard.get_square(to)
      side = color == :white ? 1 : -1

      dx = distance(x_from, x_to)
      dy = distance(y_from, y_to)

      if dx == 0 && dy == 1 && (side * (y_to - y_from)) > 0 && destination == " "
      elsif dx == 0 && dy == 2 && (y_from == 1 || y_from == 6)
      elsif dx == 1 && dy == 1 && enemy?(destination)
      else
        return false
      end
      super
    end
  end

  class Knight < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)

      dx = x_from - x_to
      dy = y_from - y_to

      knight_moves = [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2]]

      if knight_moves.include?([dx, dy])
      else
        return false
      end
      super
    end
  end

  class Bishop < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)

      dx = (x_from - x_to).abs
      dy = (y_from - y_to).abs

      bishop_moves = chessboard.get_squares(location, to)
      if !bishop_moves.empty? && chessboard.going_diagonally?(dx, dy)
      else
        return false
      end
      super
    end
  end

  class Rook < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)

      dx = (x_from - x_to).abs
      dy = (y_from - y_to).abs

      rook_moves = chessboard.get_squares(location, to)
      if !rook_moves.empty? && !chessboard.going_diagonally?(dx, dy)
      else
        return false
      end
      super
    end
  end

  class Queen < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
      queen_moves = chessboard.get_squares(location, to)
      if !queen_moves.empty?
      else
        return false
      end
      super
    end
  end

  class King < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
      x_from, y_from = get_xy(location)
      x_to, y_to = get_xy(to)
      destination = chessboard.get_square(to)

      dx = distance(x_from, x_to)
      dy = distance(y_from, y_to)

      king_moves = [[-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0]]

      if king_moves.include?([dx, dy])
      else
        return false
      end
      super
    end
  end
end
