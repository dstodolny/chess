module Chess
  describe Chessboard do
    context "#initialize" do
      it "initializes the chessboard with a grid" do
        expect { Chessboard.new(grid: "grid") }.to_not raise_error
      end

      it "sets the grid with 8 rows by default" do
        expect(Chessboard.new.grid.size).to eq 8
      end

      it "set the grid with 8 things by default" do
        chessboard = Chessboard.new
        chessboard.grid.each do |row|
          expect(row.size).to eq 8
        end
      end
    end

    context "#grid" do
      it "returns the grid" do
        chessboard = Chessboard.new(grid: "foobar")
        expect(chessboard.grid).to eq "foobar"
      end
    end

    context "#get_square" do

    end
  end
end
