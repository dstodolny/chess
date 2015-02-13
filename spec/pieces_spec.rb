module Chess
  describe Piece do
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
  end

  describe Pawn do
    it { is_expected.to be_a(Piece) }
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
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
