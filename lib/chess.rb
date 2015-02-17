require_relative "chess/version"

module Chess
  module ChessHelper
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

    def distance(from, to)
      (from - to).abs
    end

    def other_color(color)
      color == :white ? :black : :white
    end

    def get_sans(from, to) # get list of standard algebraic notation coordinates
      (from[0]..to[0]).to_a.map { |e| e + from[1] }
    end

    def get_castling_san(rook_position)
      rook_position[0] == "H" ? "G" + rook_position[1] : "C" + rook_position[1]
    end

    def neighbours(letter)
      neighbours = [(letter.upcase.ord - 1).chr, (letter.upcase.ord + 1).chr]
      neighbours.delete_if { |letter| letter < "A" || letter > "H" }
    end
  end
end

lib_path = File.expand_path(File.dirname(__FILE__))
Dir[lib_path + "/chess/**/*.rb"].each { |file| require file }
