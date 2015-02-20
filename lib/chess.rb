require_relative "chess/version"
require 'open-uri'
require 'pstore'

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

    def get_san(xy)
      x = xy[0]
      y = xy[1]
      return nil if x < 0 || x > 7 || y < 0 || y > 7

      letters = {
        0 => "A", 1 => "B", 2 => "C", 3 => "D",
        4 => "E", 5 => "F", 6 => "G", 7 => "H"
      }
      letters[x] + (y + 1).to_s
    end

    def distance(from, to)
      (from - to).abs
    end

    def other_color(color)
      color == :white ? :black : :white
    end

    def get_sans(from, to) # get list of standard algebraic notation coordinates
      if from[0] < to[0]
        (from[0]..to[0]).to_a.map { |e| e + from[1] }
      else
        (to[0]..from[0]).to_a.map { |e| e + from[1] }.reverse
      end
    end

    def get_castling_san(rook_position)
      rook_position[0] == "H" ? "G" + rook_position[1] : "C" + rook_position[1]
    end

    def neighbours(letter)
      neighbours = [(letter.upcase.ord - 1).chr, (letter.upcase.ord + 1).chr]
      neighbours.delete_if { |letter| letter < "A" || letter > "H" }
    end

    def all_moves
      moves = []
      ("A".."H").each { |let| 1.upto(8) { |num| moves << let + num.to_s } }
      moves
    end
  end
end

lib_path = File.expand_path(File.dirname(__FILE__))
Dir[lib_path + "/chess/**/*.rb"].each { |file| require file }
