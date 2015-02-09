module Chess
  describe Square do
    context "#initialize" do
      it "creates a square" do
        expect {Square.new}.to_not raise_error
      end

      it "sets the value to a empty string by default" do
        expect(Square.new.value).to eq ""
      end
    end
  end
end
