module Chess
  describe Board do
    context "#initialize" do
      it "initializes the board with a grid" do
        expect { Board.new(grid: "grid") }.to_not raise_error
      end

      it "sets the grid with 8 rows by default" do
        expect(Board.new.grid.size).to eq 8
      end

      it "set the grid with 8 columns by default" do
        board = Board.new
        board.grid.each do |row|
          expect(row.size).to eq 8
        end
      end
    end
  end
end
