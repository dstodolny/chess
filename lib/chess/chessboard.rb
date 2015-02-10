module Chess
  class Chessboard
    attr_reader :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    def get_square(coordinates)
      return false unless coordinates.match(/^[a-hA-H][1-8]$/)

      chessboard_num = {
        "A" => 0, "B" => 1, "C" => 2, "D" => 3,
        "E" => 4, "F" => 5, "G" => 6, "H" => 7,
        "1" => 0, "2" => 1, "3" => 2, "4" => 3,
        "5" => 4, "6" => 5, "7" => 6, "8" => 7
      }

      row = chessboard_num[coordinates[1]]
      col = chessboard_num[coordinates[0]]

      @grid[row][col]
    end

    def set_square(coordinates, value)
      get_square(coordinates).value = value
    end

    private

    def default_grid
      Array.new(8) { Array.new(8) { Square.new } }
    end
  end
end
