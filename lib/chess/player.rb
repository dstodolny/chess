module Chess
  class Player
    attr_accessor :name, :color
    
    def initialize(input)
      @name = input.fetch(:name)
      @color = input.fetch(:color)
    end
  end
end
