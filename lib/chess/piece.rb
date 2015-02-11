module Chess
  class Piece
    attr_reader :color, :possible_moves

    def initialize(input = {})
      @color = input.fetch(:color, :white)
      @possible_moves = []
    end
  end

  class Pawn < Piece
    def initialize
      super
    end
  end

  class Knight < Piece
    def initialize
      super
    end
  end

  class Bishop < Piece
    def initialize
      super
    end
  end

  class Rook < Piece
    def initialize
      super
    end
  end

  class Queen < Piece
    def initialize
      super
    end
  end

  class King < Piece
    def initialize
      super
    end
  end
end
