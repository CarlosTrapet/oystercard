require 'oystercard'

describe Oystercard do
subject(:card) {described_class.new}
let(:station) {'a station'}
let(:entry_station) {double :station}
let(:exit_station) { double :station }
# let(:card_with_balance) do
#   card.top_up(50)
#   card_with_balance
# end


  describe "#initialize" do

    it "should have a default balance of #{Oystercard::DEFAULT_BALANCE}" do
      expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
    end


  end

  describe "#top-up" do

    it 'should top-up oyster by n amount' do
      expect{ card.top_up(5) }.to change{ card.balance }.by 5
    end

    it 'should not exceed maximum limit' do
      expect{ card.top_up(Oystercard::MAXIMUM_LIMIT + 1) }.to raise_error("Exceeded top-up maximum amount of #{Oystercard::MAXIMUM_LIMIT}")
    end
  end

  describe "#in_journey?" do

    it "should be false at start" do
      expect(card.in_journey?). to eq false
    end
  end

  describe "#touch-in" do

    it "should change in-journey to true" do
      card.top_up(5)
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end

    it 'stores the entry station' do
      card.top_up(5)
      card.touch_in(station)
      expect(card.entry_station).to eq station
end

  end

  describe "#touch-out" do

    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it "should change in-journey back to false" do
      card.touch_out(station)
      expect(card.in_journey?).to eq false
    end
    it "should deduct from card when touched out" do
      expect { card.touch_out(station) }.to change{ card.balance }.by(-2)
    end

    it 'stores the exit station' do
      card.top_up(5)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.exit_station).to eq station
    end

  end

  describe "#insufficient funds" do
    it "Gives an error if insufficient funds on card when touch-in" do
      allow(card).to receive(:balance).and_return(0)
      expect{ card.touch_in(station) }.to raise_error("Insufficient funds")
    end
  end

end
