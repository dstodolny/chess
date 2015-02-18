module Chess
  class Player
    attr_reader :name, :color

    def initialize(input = {})
      @name = input.fetch(:name, "player")
      @color = input.fetch(:color, :white)
    end

    def king(chessboard)
      chessboard.get_pieces(color).select { |piece| piece.instance_of?(King) }.first
    end
  end
end
