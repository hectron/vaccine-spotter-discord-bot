require_relative "../discord_command"

describe DiscordCommand do
  let(:instance) { described_class.new(discord_args) }

  context "one-word cities" do
    context "milwaukee" do
      let(:discord_args) { ["Milwaukee"] }

      it "parses correctly" do
        expect(instance.city).to eq("Milwaukee")
        expect(instance.zipcodes).to be_empty
      end
    end
  end

  context "multi-word cities" do
    context "LA" do
      let(:discord_args) { ["Los", "Angeles", "90210", "90200"] }

      it "parses correctly" do
        expect(instance.city).to eq("Los Angeles")
        expect(instance.zipcodes).to match_array(["90210", "90200"])
      end
    end

    context "St. Petersburg" do
      let(:discord_args) { ["St.", " ", "Petersburg"] }

      it "parses correctly" do
        expect(instance.city).to eq("St. Petersburg")
        expect(instance.zipcodes).to be_empty
      end
    end
  end

  context "only zip codes" do
    let(:discord_args) { ["60601", "", "", "60613"] }

    it "parses correctly" do
      expect(instance.city).to be_nil
      expect(instance.zipcodes).to match_array(["60601", "60613"])
    end
  end
end
