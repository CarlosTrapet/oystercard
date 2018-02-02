require 'journey'
require 'oystercard'

describe Journey do

  # it { is_expected.to respond_to(:store_journey) }

  subject(:journey) { Journey.new }
  let(:card) { Oystercard.new(50) }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:example_journey) { {:entry => entry_station, :exit => exit_station} }

  describe "#details" do

  it "starts as empty" do
    expect(journey.details).to eq ({})
  end

    it "stores a completed journey" do
      journey.entry_station = entry_station
      journey.exit_station = exit_station
      journey.update_details
      expect(journey.details).to eq (example_journey)
    end
  end

  describe '#complete?' do
    it 'returns false for a journey with no exit_station' do 
      journey.entry_station = entry_station
      expect(journey).not_to be_complete
    end
    it 'returns true for a journey with entry and exit stations' do 
      journey.entry_station = entry_station
      journey.exit_station = exit_station
      expect(journey).to be_complete
    end
  end

  describe '#fare' do 
    before do 
      journey.exit_station = exit_station
    end
    it 'returns minimum fare for a complete journey' do 
      journey.entry_station = entry_station
      expect(journey.fare).to eq described_class::MINIMUM_FARE
    end
    it "returns penalty fare for an incomplete journey" do 
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end
  end
end
