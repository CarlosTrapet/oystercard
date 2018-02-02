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

end
