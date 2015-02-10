module Chess
  class Piece
    attr_reader :color

    def initialize(input = {})
      @color = input.fetch(:color, :white)
    end
  end
end
