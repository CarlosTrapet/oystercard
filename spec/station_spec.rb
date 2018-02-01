require 'station'

describe Station do

  subject(:station) { described_class.new(name) }

  describe "#initialize" do
    it "store a name" do
    expect(station.name).to eq name
  end
end
end
