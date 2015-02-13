module Chess
  class Piece
    attr_accessor :location
    attr_reader :color

    def initialize(input = {})
      @color = input.fetch(:color, :white)
      @location = input.fetch(:location, "A1")
    end
  end
end
