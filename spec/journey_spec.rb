require 'journey'
require 'oystercard'

describe Journey do

  # it { is_expected.to respond_to(:store_journey) }

  subject(:journey) { Journey.new }
  let(:card) { Oystercard.new(50) }
  let(:example_journey) { {:entry => entry_station, :exit => exit_station} }

  describe "#history" do

    it "starts as empty" do
    expect(journey.history).to match_array([])
  end

    it "stores a completed journey" do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(journey.history).to include(example_journey)
    end
  end

end
