module Chess
  describe Cell do
    context "#initialize" do
      it "creates a cell" do
        expect {Cell.new}.to_not raise_error
      end

      it "sets the value to a empty string by default" do
        expect(Cell.new.value).to eq ""
      end
    end
  end
end
