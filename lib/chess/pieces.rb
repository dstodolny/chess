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
      elsif friendly_piece?(chessboard.get_square(to))
        return false
      elsif chessboard.path_blocked?(location, to)
        return false
      else
        return true
      end
    end

    def friendly_piece?(piece)
      piece.color == color if piece.is_a?(Piece)
    end

    def enemy_piece?(piece)
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
      square = chessboard.get_square(to)
      side = color == :white ? 1 : -1

      dx = distance(x_from, x_to)
      dy = distance(y_from, y_to)

      if dx == 0 && dy == 1 && (side * (y_to - y_from)) > 0 && square == " "
      elsif dx == 0 && dy == 2 && (y_from == 1 || y_from == 6)
      elsif dx == 1 && dy == 1 && enemy_piece?(square)
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
  end

  class Bishop < Piece
    def initialize(input = {})
      super
    end
  end

  class Rook < Piece
    def initialize(input = {})
      super
    end
  end

  class Queen < Piece
    def initialize(input = {})
      super
    end
  end

  class King < Piece
    def initialize(input = {})
      super
    end
  end
end
