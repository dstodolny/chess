module Chess
  class Chessboard
    attr_reader :board

    def initialize(input = {})
      @board = input.fetch(:board, default_board)
    end

    def move(from, to)
      valid_san = /^[a-hA-H][1-8]$/
      return false unless from != to && from.match(valid_san) && to.match(valid_san)
      
      set_square(to, get_square(from))
      clear_square(from)
    end

    def get_square(san)
      x, y = get_xy(san)
      board[y][x]
    end

    private

    def set_square(san, value)
      x, y = get_xy(san)
      board[y][x] = value
    end

    def clear_square(san)
      set_square(san, " ")
    end

    def get_xy(san)
      coordinates = {
        "A" => 0, "B" => 1, "C" => 2, "D" => 3,
        "E" => 4, "F" => 5, "G" => 6, "H" => 7,
        "1" => 0, "2" => 1, "3" => 2, "4" => 3,
        "5" => 4, "6" => 5, "7" => 6, "8" => 7
      }
      x = coordinates[san[0]]
      y = coordinates[san[1]]

      [x, y]
    end

    def default_board
      Array.new(8) { Array.new(8) { " " } }
    end
  end
end
