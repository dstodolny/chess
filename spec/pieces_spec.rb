module Chess
  describe Piece do
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }

    let(:chessboard) { Chessboard.new }

    describe "#friendly?" do
      let(:white_pawn_1) { Pawn.new(color: :white, location: "A2") }
      let(:white_pawn_2) { Pawn.new(color: :white, location: "B2") }
      let(:black_pawn) { Pawn.new(color: :black, location: "A7") }

      it { expect(white_pawn_1.friend?(white_pawn_2)).to be_truthy }
      it { expect(white_pawn_1.friend?(black_pawn)).to be_falsey }
    end

    describe "#enemy?" do
      let(:white_pawn_1) { Pawn.new(color: :white, location: "A2") }
      let(:white_pawn_2) { Pawn.new(color: :white, location: "B2") }
      let(:black_pawn) { Pawn.new(color: :black, location: "A7") }

      it { expect(white_pawn_1.enemy?(white_pawn_2)).to be_falsey }
      it { expect(white_pawn_1.enemy?(black_pawn)).to be_truthy }
    end

    describe "#to_be_promoted?" do
      context "with a pawn" do
        let(:white_pawn_1) { Pawn.new(color: :white, location: "A8") }
        let(:white_pawn_2) { chessboard.get_square("A2") }
        let(:black_pawn) { Pawn.new(color: :black, location: "B1") }
        before do
          chessboard.set_square("A8", white_pawn_1)
          chessboard.set_square("B1", black_pawn)
        end

        it { expect(white_pawn_1.to_be_promoted?).to be_truthy }
        it { expect(black_pawn.to_be_promoted?).to be_truthy }
        it { expect(white_pawn_2.to_be_promoted?).to be_falsey }
      end

      context "with any other piece" do
        let(:white_knight_1) { Knight.new(color: :white, location: "A8") }
        let(:white_knight_2) { chessboard.get_square("B1") }
        before { chessboard.set_square("A8", white_knight_1) }

        it { expect(white_knight_1.to_be_promoted?).to be_falsey }
        it { expect(white_knight_2.to_be_promoted?).to be_falsey }
      end
    end
  end

  describe Pawn do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }

    let(:chessboard) { Chessboard.new }

    describe "#valid_move?" do
      context "when moving forward to an empty square" do
        let(:white_pawn) { chessboard.get_square("B2") }
        let(:black_pawn) { chessboard.get_square("B7") }

        it { expect(black_pawn.valid_move?(chessboard, "B6")).to be_truthy }
        it { expect(white_pawn.valid_move?(chessboard, "B3")).to be_truthy }
        it { expect(white_pawn.valid_move?(chessboard, "B4")).to be_truthy }
      end

      context "when moving backward to an empty square" do
        let(:white_pawn) { Pawn.new(color: :white, location: "D5") }
        let(:black_pawn) { Pawn.new(color: :black, location: "E5") }
        before do
          chessboard.set_square("D5", white_pawn)
          chessboard.set_square("E5", black_pawn)
        end

        it { expect(white_pawn.valid_move?(chessboard, "D4")).to be_falsey }
        it { expect(black_pawn.valid_move?(chessboard, "E6")).to be_falsey }
      end

      context "when moving forward to a blocked square" do
        let(:white_pawn) { chessboard.get_square("B2") }
        before { chessboard.set_square("B3", Pawn.new(color: :white, location: "B3")) }

        it { expect(white_pawn.valid_move?(chessboard, "B3")).to be_falsey }
        it { expect(white_pawn.valid_move?(chessboard, "B4")).to be_falsey }
      end

      context "when moving to a wrong square" do
        let(:white_pawn) { chessboard.get_square("C2") }
        let(:black_pawn) { Pawn.new(color: :black, location: "D5") }
        before { chessboard.set_square("D5", black_pawn) }

        it { expect(white_pawn.valid_move?(chessboard, "C5")).to be_falsey }
        it { expect(black_pawn.valid_move?(chessboard, "E5")).to be_falsey }
        it { expect(black_pawn.valid_move?(chessboard, "D6")).to be_falsey }
        it { expect(black_pawn.valid_move?(chessboard, "E4")).to be_falsey }
      end

      context "when attacking an enemy piece" do
        let(:white_pawn) { Pawn.new(color: :white, location: "E4") }
        let(:black_pawn) { Pawn.new(color: :black, location: "D5") }
        before do
          chessboard.set_square("E4", white_pawn)
          chessboard.set_square("D5", black_pawn)
        end

        it { expect(black_pawn.valid_move?(chessboard, "E4")).to be_truthy }
      end

      context "when 'attacking' a friendly piece" do
        let(:white_pawn_1) { Pawn.new(color: :white, location: "E4") }
        let(:white_pawn_2) { Pawn.new(color: :white, location: "D5") }
        before do
          chessboard.set_square("E4", white_pawn_1)
          chessboard.set_square("D5", white_pawn_2)
        end

        it { expect(white_pawn_2.valid_move?(chessboard, "E4")).to be_falsey }
      end

      context "when black is commiting en-passant" do
        let(:black_pawn) { Pawn.new(color: :black, location: "C4") }
        before do
          chessboard.set_square("C4", black_pawn)
          chessboard.move("D2", "D4")
        end

        it { expect(black_pawn.valid_move?(chessboard, "D3")).to be_truthy }
      end

      context "when white is commiting en-passant" do
        let(:white_pawn) { Pawn.new(color: :white, location: "G5") }
        before do
          chessboard.set_square("G5", white_pawn)
          chessboard.move("F7", "F5")
        end

        it { expect(white_pawn.valid_move?(chessboard, "F6")).to be_truthy }
      end

      context "when can't commit en-passant" do
        let(:black_pawn) { Pawn.new(color: :black, location: "C4") }
        before do
          chessboard.set_square("C4", black_pawn)
          chessboard.move("D2", "D4")
          chessboard.move("A7", "A6") # black's not commiting en-passent
          chessboard.move("A2", "A3") # white's turn
        end

        it { expect(black_pawn.valid_move?(chessboard, "D3")).to be_falsey }
      end
    end

    describe "#move" do
      context "when moving one square forward" do
        before { chessboard.move("C2", "C3") }

        it { expect(chessboard.get_square("C3").passable).to be_falsey }
      end

      context "when moving two steps forward" do
        before { chessboard.move("B2", "B4") }

        it { expect(chessboard.get_square("B4").passable).to be_truthy }
      end

      context "after moving two times" do
        before do
          chessboard.move("B2", "B4")
          chessboard.move("B4", "B5")
        end

        it { expect(chessboard.get_square("B5").passable).to be_falsey }
      end
    end
  end

  describe Knight do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }

    let(:chessboard) { Chessboard.new }

    describe "#valid_move?" do
      let(:knight) { Knight.new(color: :white, location: "D5") }
      before { chessboard.set_square("D5", knight) }

      context "when moving to an empty space" do
        it { expect(knight.valid_move?(chessboard, "B6")).to be_truthy }
        it { expect(knight.valid_move?(chessboard, "F6")).to be_truthy }
        it { expect(knight.valid_move?(chessboard, "F4")).to be_truthy }
        it { expect(knight.valid_move?(chessboard, "E3")).to be_truthy }
        it { expect(knight.valid_move?(chessboard, "C3")).to be_truthy }
        it { expect(knight.valid_move?(chessboard, "B4")).to be_truthy }
      end

      context "when attacking an enemy piece" do
        it { expect(knight.valid_move?(chessboard, "C7")).to be_truthy }
        it { expect(knight.valid_move?(chessboard, "E7")).to be_truthy }
      end

      context "when moving to a wrong square" do
        it { expect(knight.valid_move?(chessboard, "C5")).to be_falsey }
        it { expect(knight.valid_move?(chessboard, "B7")).to be_falsey }
        it { expect(knight.valid_move?(chessboard, "D3")).to be_falsey }
      end
    end
  end

  describe Bishop do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }

    let(:chessboard) { Chessboard.new }

    describe "#valid_move?" do
      let(:bishop) { Bishop.new(color: :white, location: "E4") }
      before { chessboard.set_square("E4", bishop) }

      context "when moving to an empty space" do
        it { expect(bishop.valid_move?(chessboard, "C6")).to be_truthy }
        it { expect(bishop.valid_move?(chessboard, "G6")).to be_truthy }
        it { expect(bishop.valid_move?(chessboard, "D3")).to be_truthy }
        it { expect(bishop.valid_move?(chessboard, "F3")).to be_truthy }
      end

      context "when attacking an enemy piece" do
        it { expect(bishop.valid_move?(chessboard, "B7")).to be_truthy }
        it { expect(bishop.valid_move?(chessboard, "H7")).to be_truthy }
      end

      context "when moving to a wrong square" do
        it { expect(bishop.valid_move?(chessboard, "B4")).to be_falsey }
        it { expect(bishop.valid_move?(chessboard, "E7")).to be_falsey }
        it { expect(bishop.valid_move?(chessboard, "C2")).to be_falsey }
      end

      context "when moving through a blocked square" do
        let(:pawn) { Pawn.new(color: :black, location: "D5") }
        before { chessboard.set_square("D5", pawn) }

        it { expect(bishop.valid_move?(chessboard, "C6")).to be_falsey }
      end
    end
  end

  describe Rook do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }

    let(:chessboard) { Chessboard.new }

    describe "#valid_move?" do
      let(:rook) { Rook.new(color: :white, location: "D4") }
      before { chessboard.set_square("D4", rook) }

      context "when moving to an empty space" do
        it { expect(rook.valid_move?(chessboard, "A4")).to be_truthy }
        it { expect(rook.valid_move?(chessboard, "H4")).to be_truthy }
        it { expect(rook.valid_move?(chessboard, "D6")).to be_truthy }
        it { expect(rook.valid_move?(chessboard, "D3")).to be_truthy }
      end

      context "when attacking an enemy piece" do
        it { expect(rook.valid_move?(chessboard, "D7")).to be_truthy }
      end

      context "when moving to a wrong square" do
        it { expect(rook.valid_move?(chessboard, "B6")).to be_falsey }
        it { expect(rook.valid_move?(chessboard, "D2")).to be_falsey }
        it { expect(rook.valid_move?(chessboard, "F3")).to be_falsey }
      end

      context "when moving through a blocked square" do
        let(:pawn) { Pawn.new(color: :black, location: "D5") }
        before { chessboard.set_square("D5", pawn) }

        it { expect(rook.valid_move?(chessboard, "D6")).to be_falsey }
      end
    end
  end

  describe Queen do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }

    let(:chessboard) { Chessboard.new }

    describe "#valid_move?" do
      let(:queen) { Queen.new(color: :white, location: "D4") }
      before { chessboard.set_square("D4", queen) }

      context "when moving to an empty space" do
        it { expect(queen.valid_move?(chessboard, "A4")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "H4")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "D6")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "D3")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "B6")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "F6")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "C3")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "E3")).to be_truthy }
      end

      context "when attacking an enemy piece" do
        it { expect(queen.valid_move?(chessboard, "D7")).to be_truthy }
        it { expect(queen.valid_move?(chessboard, "G7")).to be_truthy }
      end

      context "when moving to a wrong square" do
        it { expect(queen.valid_move?(chessboard, "C6")).to be_falsey }
        it { expect(queen.valid_move?(chessboard, "B2")).to be_falsey }
      end

      context "when moving through a blocked square" do
        let(:pawn) { Pawn.new(color: :black, location: "G4") }
        before { chessboard.set_square("G4", pawn) }

        it { expect(queen.valid_move?(chessboard, "H4")).to be_falsey }
      end
    end
  end

  describe King do
    it { is_expected.to be_a(King) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }

    let(:chessboard) { Chessboard.new }

    describe "#valid_move?" do
      let(:king) { King.new(color: :white, location: "D5") }
      before { chessboard.set_square("D5", king) }

      context "when moving to an empty space" do
        it { expect(king.valid_move?(chessboard, "C6")).to be_truthy }
        it { expect(king.valid_move?(chessboard, "D6")).to be_truthy }
        it { expect(king.valid_move?(chessboard, "E6")).to be_truthy }
        it { expect(king.valid_move?(chessboard, "E5")).to be_truthy }
        it { expect(king.valid_move?(chessboard, "E4")).to be_truthy }
        it { expect(king.valid_move?(chessboard, "D4")).to be_truthy }
        it { expect(king.valid_move?(chessboard, "C4")).to be_truthy }
        it { expect(king.valid_move?(chessboard, "C5")).to be_truthy }
      end

      context "when attacking an enemy piece" do
        let(:king) { King.new(color: :white, location: "A6") }
        before { chessboard.set_square("A6", king) }

        it { expect(king.valid_move?(chessboard, "A7")).to be_truthy }
      end

      context "when moving to a wrong square" do
        it { expect(king.valid_move?(chessboard, "B5")).to be_falsey }
        it { expect(king.valid_move?(chessboard, "C2")).to be_falsey }
      end
    end

    describe "#in_check?" do
      let(:white_king) { King.new(color: :white, location: "D3") }
      let(:black_bishop) { Bishop.new(color: :black, location: "G6") }
      before do
        chessboard.set_square("D3", white_king)
        chessboard.set_square("G6", black_bishop)
      end

      it { expect(white_king.in_check?(chessboard, "D3")).to be_truthy }
      it { expect(chessboard.get_square("E1").in_check?(chessboard, "E1")).to be_falsey }
    end

    describe "#can_castle?" do
      before do
        chessboard.clear_square("E2")
        chessboard.clear_square("B1")
        chessboard.clear_square("C1")
        chessboard.clear_square("D1")
        chessboard.clear_square("F1")
        chessboard.clear_square("G1")
        chessboard.clear_square("H2")
        chessboard.clear_square("F8")
        chessboard.clear_square("G8")
      end

      context "when doing a short castle" do
        it { expect(chessboard.get_square("E1").can_castle?(chessboard, "H1")).to be_truthy }
        it { expect(chessboard.get_square("E8").can_castle?(chessboard, "H8")).to be_truthy }
      end

      context "when doing a long castle" do
        it { expect(chessboard.get_square("E1").can_castle?(chessboard, "A1")).to be_truthy }
      end

      context "when king was moved" do
        before do
          chessboard.move("E1", "E2")
          chessboard.move("E2", "E1")
        end

        it { expect(chessboard.get_square("E1").can_castle?(chessboard, "H1")).to be_falsey }
      end

      context "when rook was moved" do
        before do
          chessboard.move("H1", "H2")
          chessboard.move("H2", "H1")
        end

        it { expect(chessboard.get_square("E1").can_castle?(chessboard, "H1")).to be_falsey }
      end

      context "when king is in check" do
        before do
          chessboard.set_square("E5", Rook.new(color: :black, location: "E5"))
        end

        it { expect(chessboard.get_square("E1").can_castle?(chessboard, "H1")).to be_falsey }
      end

      context "when castling through check" do
        before do
          chessboard.set_square("B5", Bishop.new(color: :black, location: "B5"))
        end

        it { expect(chessboard.get_square("E1").can_castle?(chessboard, "H1")).to be_falsey }
      end

      context "when castling position is in check" do
        before do
          chessboard.set_square("H2", Pawn.new(color: :black, location: "H2"))
          chessboard.set_square("H7", Pawn.new(color: :white, location: "H7"))
        end

        it { expect(chessboard.get_square("E1").can_castle?(chessboard, "H1")).to be_falsey }
        it { expect(chessboard.get_square("E8").can_castle?(chessboard, "H8")).to be_falsey }
      end
    end

    describe "#valid_moves" do
      before do
        chessboard.set_square("E5", King.new(color: :white, location: "E5"))
        chessboard.set_square("A5", King.new(color: :black, location: "A5"))
      end

      it { expect(chessboard.get_square("E5").valid_moves.size).to eq 8 }
      it { expect(chessboard.get_square("E5").valid_moves).to contain_exactly("D6", "E6", "F6", "F5", "F4", "E4", "D4", "D5") }
      it { expect(chessboard.get_square("A5").valid_moves.size).to eq 5 }
      it { expect(chessboard.get_square("A5").valid_moves).to contain_exactly("A6", "B6", "B5", "B4", "A4") }
    end
  end
end
