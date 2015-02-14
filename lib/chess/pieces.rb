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
        false
      elsif friendly_piece?(chessboard.get_square(to))
        false
      elsif chessboard.path_blocked?(location, to)
        false
      else
        true
      end
    end

    def friendly_piece?(piece)
      piece.color == color if piece.is_a?(Piece)
    end
  end

  class Pawn < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
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
