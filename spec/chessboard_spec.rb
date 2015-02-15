module Chess
  describe Chessboard do
    board = [["foo", " ", " "], [" ", "bar", " "], [" ", " ", "baz"]]
    let(:chessboard) { Chessboard.new(board: board) }

    it { is_expected.to respond_to :board }

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

    describe "#set_square" do
      let(:chessboard) { Chessboard.new }
      before { chessboard.set_square("D5", "foo") }

      it { expect(chessboard.get_square("D5")).to eq "foo" }
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
        it { expect(chessboard.move("C3", "C3")).to be_falsey }
        it { expect(chessboard.move("I9", "I8")).to be_falsey }
        it { expect(chessboard.move("99", "98")).to be_falsey }
        it { expect(chessboard.move("AA", "BB")).to be_falsey }
        it { expect(chessboard.move("", "")).to be_falsey }
        it { expect(chessboard.move("abcdefg", "ijklmno")).to be_falsey }
        it { expect(chessboard.move("1234567", "7654321")).to be_falsey }
        it { expect(chessboard.move("A11", "BB1")).to be_falsey }
      end
    end

    describe "#get_squares" do
      let(:chessboard) { Chessboard.new }

      context "with same squares" do
        let(:squares) { chessboard.get_squares("A1", "A1") }

        it { expect(squares.size).to eq 1 }
        it { expect(squares[0]).to be_instance_of(Rook) }
      end

      context "with squares distanced horizontally" do
        let(:squares_1) { chessboard.get_squares("D1", "A1") }
        let(:squares_2) { chessboard.get_squares("H7", "F7") }

        it { expect(squares_1.size).to eq 4 }
        it { expect(squares_2.size).to eq 3 }
        it { expect(squares_1).to contain_exactly(Queen, Bishop, Knight, Rook) }
      end

      context "with squares distanced vertically" do
        let(:squares_1) { chessboard.get_squares("B1", "B3") }
        let(:squares_2) { chessboard.get_squares("E5", "E8") }

        it { expect(squares_1.size).to eq 3 }
        it { expect(squares_2.size).to eq 4 }
        it { expect(squares_1).to contain_exactly(Knight, Pawn, " ") }
        it { expect(squares_2).to contain_exactly(" ", " ", Pawn, King) }
      end

      context "with squares distanced diagonally" do
        let(:squares_1) { chessboard.get_squares("E1", "H4") }
        let(:squares_2) { chessboard.get_squares("H8", "A1") }

        it { expect(squares_1.size).to eq 4 }
        it { expect(squares_2.size).to eq 8 }
        it { expect(squares_1).to contain_exactly(King, Pawn, " ", " ") }
        it { expect(squares_2).to contain_exactly(Rook, Pawn, " ", " ", " ", " ", Pawn, Rook) }
      end

      context "with squares that doesn't lie on a line" do
        it { expect(chessboard.get_squares("A1", "B6")).to be_empty }
      end
    end

    describe "#going_vertically?" do
      it { expect(chessboard.going_vertically?(0, 1)).to be_truthy }
      it { expect(chessboard.going_vertically?(1, 0)).to be_falsey }
      it { expect(chessboard.going_vertically?(1, 1)).to be_falsey }
    end

    describe "#going_horizontally?" do
      it { expect(chessboard.going_horizontally?(0, 1)).to be_falsey }
      it { expect(chessboard.going_horizontally?(1, 0)).to be_truthy }
      it { expect(chessboard.going_horizontally?(1, 1)).to be_falsey }
    end

    describe "#going_diagonally?" do
      it { expect(chessboard.going_diagonally?(0, 1)).to be_falsey }
      it { expect(chessboard.going_diagonally?(1, 0)).to be_falsey }
      it { expect(chessboard.going_diagonally?(1, 1)).to be_truthy }
    end

    describe "#path_blocked?" do
      let(:chessboard) { Chessboard.new }
      before { chessboard.set_square("C5", Pawn.new(color: :white, location: "C5")) }

      it { expect(chessboard.path_blocked?("C2", "C7")).to be_truthy }
      it { expect(chessboard.path_blocked?("A2", "D2")).to be_truthy }
      it { expect(chessboard.path_blocked?("H1", "E4")).to be_truthy }
      it { expect(chessboard.path_blocked?("B2", "B7")).to be_falsey }
      it { expect(chessboard.path_blocked?("F2", "C5")).to be_falsey }
    end
  end
end
