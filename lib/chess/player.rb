module Chess
  class Player
    attr_reader :name, :color
    
    def initialize(input)
      @name = input.fetch(:name)
      @color = input.fetch(:color)
    end
  end
end
