module Chess
  class Player
    attr_reader :name, :color

    def initialize(input = {})
      @name = input.fetch(:name, "player")
      @color = input.fetch(:color, :white)
    end
  end
end
