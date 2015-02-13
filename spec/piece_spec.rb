module Chess
  describe Piece do
    it { is_expected.to respond_to :color }
    it { is_expected.to respond_to :location }
  end
end
