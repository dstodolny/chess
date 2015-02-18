module Chess
  describe Game do
    let(:game) { Game.new }

    describe "#switch_players" do
      before { game.switch_players }

      it { expect(game.current_player.color).to eq :black }
      it { expect(game.other_player.color).to eq :white }
    end

  end
end
