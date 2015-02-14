module Chess
  class Piece
    attr_accessor :location
    attr_reader :color

    def initialize(input = {})
      @color = input.fetch(:color, :white)
      @location = input.fetch(:location, "A1")
    end
  end

  class Pawn < Piece
    def initialize(input = {})
      super
    end

    def valid_move?(chessboard, to)
      true
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
