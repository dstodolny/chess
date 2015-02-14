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

    def set_square(san, value)
      x, y = get_xy(san)
      board[y][x] = value
    end

    private

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
      board = Array.new(8) { Array.new(8) { " " } }

      board[0][0] = Rook.new(color: :white, location: "A1")
      board[0][1] = Knight.new(color: :white, location: "B1")
      board[0][2] = Bishop.new(color: :white, location: "C1")
      board[0][3] = Queen.new(color: :white, location: "D1")
      board[0][4] = King.new(color: :white, location: "E1")
      board[0][5] = Bishop.new(color: :white, location: "F1")
      board[0][6] = Knight.new(color: :white, location: "G1")
      board[0][7] = Rook.new(color: :white, location: "H1")

      board[1][0] = Pawn.new(color: :white, location: "A2")
      board[1][1] = Pawn.new(color: :white, location: "B2")
      board[1][2] = Pawn.new(color: :white, location: "C2")
      board[1][3] = Pawn.new(color: :white, location: "D2")
      board[1][4] = Pawn.new(color: :white, location: "E2")
      board[1][5] = Pawn.new(color: :white, location: "F2")
      board[1][6] = Pawn.new(color: :white, location: "G2")
      board[1][7] = Pawn.new(color: :white, location: "H2")

      board[6][0] = Pawn.new(color: :black, location: "A7")
      board[6][1] = Pawn.new(color: :black, location: "B7")
      board[6][2] = Pawn.new(color: :black, location: "C7")
      board[6][3] = Pawn.new(color: :black, location: "D7")
      board[6][4] = Pawn.new(color: :black, location: "E7")
      board[6][5] = Pawn.new(color: :black, location: "F7")
      board[6][6] = Pawn.new(color: :black, location: "G7")
      board[6][7] = Pawn.new(color: :black, location: "H7")

      board[7][0] = Rook.new(color: :black, location: "A8")
      board[7][1] = Knight.new(color: :black, location: "B8")
      board[7][2] = Bishop.new(color: :black, location: "C8")
      board[7][3] = Queen.new(color: :black, location: "D8")
      board[7][4] = King.new(color: :black, location: "E8")
      board[7][5] = Bishop.new(color: :black, location: "F8")
      board[7][6] = Knight.new(color: :black, location: "G8")
      board[7][7] = Rook.new(color: :black, location: "H8")

      board
    end
  end
end
