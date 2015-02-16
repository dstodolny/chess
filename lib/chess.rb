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
  end
end

lib_path = File.expand_path(File.dirname(__FILE__))
Dir[lib_path + "/chess/**/*.rb"].each { |file| require file }
