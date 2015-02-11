module Chess
  describe Piece do
    context "#initialize" do
      it "creates a piece" do
        expect { Piece.new }.to_not raise_error
      end

      it "sets the color to :white by default" do
        expect(Piece.new.color).to eq :white
      end

      it "creates an Array of possible moves" do
        expect(Piece.new.possible_moves).to be_instance_of Array
      end
    end
  end

  describe Pawn do
    context "#initialize" do
      it "creates a pawn" do
        expect { Pawn.new }.to_not raise_error
      end

      it "inherits from Piece" do
        expect(Pawn.new).kind_of? Piece
      end
    end
  end

  describe Knight do
    context "#initialize" do
      it "creates a knight" do
        expect { Knight.new }.to_not raise_error
      end

      it "inherits from Piece" do
        expect(Knight.new).kind_of? Piece
      end
    end
  end
  
  describe Bishop do
    context "#initialize" do
      it "creates a bishop" do
        expect { Bishop.new }.to_not raise_error
      end

      it "inherits from Piece" do
        expect(Bishop.new).kind_of? Piece
      end
    end
  end

  describe Rook do
    context "#initialize" do
      it "creates a rook" do
        expect { Rook.new }.to_not raise_error
      end

      it "inherits from Piece" do
        expect(Rook.new).kind_of? Piece
      end
    end
  end

  describe Queen do
    context "#initialize" do
      it "creates a queen" do
        expect { Queen.new }.to_not raise_error
      end

      it "inherits from Piece" do
        expect(Queen.new).kind_of? Piece
      end
    end
  end

  describe King do
    context "#initialize" do
      it "creates a king" do
        expect { King.new }.to_not raise_error
      end

      it "inherits from Piece" do
        expect(King.new).kind_of? Piece
      end
    end
  end
end


