module Chess
  describe Player do
    it { should respond_to :name }
    it { should respond_to :color }

    let(:player) { Player.new(name: "George", color: :black) }

    context "#name" do
      it "returns player's name" do
        expect(player.name).to eq "George"
      end
    end

    context "#color" do
      it "returns player's color" do
        expect(player.color).to eq :black
      end
    end
  end
end
