module Chess
  describe Pawn do
    context "#initialize" do
      it "creates a pawn" do
        expect { Pawn.new }.to_not raise_error
      end

      it "sets default pawn symbol" do
        expect(Pawn.new.symbol).to eq "\u2659"
      end
    end
  end
end
