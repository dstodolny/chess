module Chess
  class Chessboard
    attr_reader :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    private

    def default_grid
      Array.new(8) { Array.new(8) { Cell.new } }
    end
  end
end