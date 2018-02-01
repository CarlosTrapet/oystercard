require 'station'

describe Station do

  subject(:station) { described_class.new(:aldgate, 2) }

  describe "#initialize" do

    it "store a name" do
    expect(station.name).to eq :aldgate
    end

    it "stores a zone" do 
      expect(station.zone).to eq 2
    end
  end
end
