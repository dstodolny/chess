module Chess
  describe Piece do
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
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
    end

    describe "#friendly_piece?" do
      let(:white_pawn_1) { Pawn.new(color: :white, location: "A2") }
      let(:white_pawn_2) { Pawn.new(color: :white, location: "B2") }
      let(:black_pawn) { Pawn.new(color: :black, location: "A7") }

      it { expect(white_pawn_1.friendly_piece?(white_pawn_2)).to be_truthy }
      it { expect(white_pawn_1.friendly_piece?(black_pawn)).to be_falsey }
    end
  end

  describe Knight do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
  end

  describe Bishop do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
  end

  describe Rook do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
  end

  describe Queen do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
  end

  describe King do
    it { is_expected.to be_a(King) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
  end
end
