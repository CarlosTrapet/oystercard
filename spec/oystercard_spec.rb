require 'oystercard'

describe Oystercard do
subject(:card) {described_class.new}
let(:station) {'a station'}
let(:entry_station) {double :station}
let(:exit_station) { double :station }
let(:minimum_fare) { 2 }
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

  describe "#touch-in" do

    # it 'stores the entry station' do
    #   card.top_up(5)
    #   card.touch_in(station)
    #   expect(card.entry_station).to eq station
    # end

  end

  describe "#touch-out" do
    before do 
      card.top_up(10)
      card.touch_in(entry_station)
    end

    it "should deduct from card when touched out" do
      card.touch_in(entry_station)
      expect { card.touch_out(station) }.to change{ card.balance }.by(-minimum_fare)
    end

    it 'stores the journey details' do
      current_journey = { :entry => entry_station, :exit => exit_station }
      card.touch_out(exit_station)
      expect(card.history).to include(current_journey)
    end

  end

  describe "#insufficient funds" do
    it "Gives an error if insufficient funds on card when touch-in" do
      allow(card).to receive(:balance).and_return(0)
      expect{ card.touch_in(station) }.to raise_error("Insufficient funds")
    end
  end

end
