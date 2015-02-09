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
      it "returns the square based on the chess coordinate system" do
        grid = [["", "", ""], ["", "", "foobar"], ["", "", ""]]
        chessboard = Chessboard.new(grid: grid)
        expect(chessboard.get_square("C2")).to eq "foobar"
      end

      it "returns false when used with wrong argument" do
        chessboard = Chessboard.new
        expect(chessboard.get_square("I9")).to be false
        expect(chessboard.get_square("99")).to be false
        expect(chessboard.get_square("AA")).to be false
        expect(chessboard.get_square("")).to be false
        expect(chessboard.get_square("abcdefg")).to be false
        expect(chessboard.get_square("1234567")).to be false
        expect(chessboard.get_square("A11")).to be false
      end
    end
  end
end
