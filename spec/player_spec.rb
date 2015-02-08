module Chess
  describe Player do
    context "#initialize" do
      it "raises an exception when initialized with {}" do
        expect { Player.new({}) }.to raise_error
      end

      it "does not raises an exception when initialized with valid input hash" do
        expect { Player.new(name: "Joe", color: :white) }.to_not raise_error
      end
    end

    context "#name" do
      it "returns player's name" do
        player = Player.new(name: "Joe", color: :white)
        expect(player.name).to eq "Joe"
      end
    end

    context "#color" do
      it "returns player's color" do
        player = Player.new(name: "Joe", color: :white)
        expect(player.color).to eq :white
      end
    end
  end
end
