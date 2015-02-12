module Chess
  describe Player do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :color }

    let(:player) { Player.new(name: "George", color: :black) }

    describe "#name" do
      it "returns player's name" do
        expect(player.name).to eq "George"
      end
    end

    describe "#color" do
      it "returns player's color" do
        expect(player.color).to eq :black
      end
    end
  end
end
