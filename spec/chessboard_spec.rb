module Chess
  describe Chessboard do
    board = [["foo", " ", " "], [" ", "bar", " "], [" ", " ", "baz"]]
    let(:chessboard) { Chessboard.new(board: board) }

    it { should respond_to :board }

    describe "#initialize" do
      it "sets the board with eight rows by default" do
        expect(Chessboard.new.board.size).to eq 8
      end

      it "creates eight things in each row by default" do
        Chessboard.new.board.each do |row|
          expect(row.size).to eq 8
        end
      end
    end

    describe "#get_square" do
      it { expect(chessboard.get_square("A1")).to eq "foo" }
      it { expect(chessboard.get_square("B2")).to eq "bar" }
      it { expect(chessboard.get_square("C3")).to eq "baz" }
    end

    describe "#move" do
      context "with valid move" do
        it "moves a thing from a one square to another" do
          chessboard.move("C3", "C2")
          expect(chessboard.get_square("C2")).to eq "baz"
          expect(chessboard.get_square("C3")).to eq " "
        end
      end

      context "with invalid move" do
        it { expect(chessboard.move("C3", "C3")).to be false }
        it { expect(chessboard.move("I9", "I8")).to be false }
        it { expect(chessboard.move("99", "98")).to be false }
        it { expect(chessboard.move("AA", "BB")).to be false }
        it { expect(chessboard.move("", "")).to be false }
        it { expect(chessboard.move("abcdefg", "ijklmno")).to be false }
        it { expect(chessboard.move("1234567", "7654321")).to be false }
        it { expect(chessboard.move("A11", "BB1")).to be false }
      end
    end

    # private methods

    # describe "#set_square" do
    #   it "replaces a square with a new thing" do
    #     chessboard.set_square("B2", "foo")
    #     expect(chessboard.get_square("B2")).to eq "foo"
    #   end
    # end

    # describe "#clear_square" do
    #   it "inserts a whitespace character to a square" do
    #     chessboard.clear_square("A1")
    #     expect(chessboard.get_square("A1")).to eq " "
    #   end
    # end
  end
end
