module Chess
  describe Piece do
    context "#initialize" do
      it "creates a piece" do
        expect { Piece.new }.to_not raise_error
      end

      it "sets the color to :white by default" do
        expect(Piece.new.color).to eq :white
      end
    end
  end
end
