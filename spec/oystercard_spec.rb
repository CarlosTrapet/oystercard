require 'oystercard'

describe Oystercard do
let(:station) {'a station'}
let(:entry_station) {double :station}

  describe "#new card" do

    it "should have a default balance of #{Oystercard::DEFAULT_BALANCE}" do
      expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
    end

  end

  describe "#top-up" do

    it 'should top-up oyster by n amount' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it 'should not exceed maximum limit' do
      expect{ subject.top_up(Oystercard::MAXIMUM_LIMIT + 1) }.to raise_error("Exceeded top-up maximum amount of #{Oystercard::MAXIMUM_LIMIT}")
    end
  end

  # describe "#deduct" do
  #
  #   it "should deduct oyster bt n amount" do
  #     expect{ subject.deduct(5) }.to change{ subject.balance }.by(-5)
  #   end
  # end

  describe "#in_journey?" do

    it "should be false at start" do
      expect(subject.in_journey?). to eq false
    end
  end

  describe "#touch-in" do
    # let(:station){ double :station }
    it "should change in-journey to true" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    # let(:station){ double :station }
    it 'stores the entry station' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
end

  end

  describe "#touch-out" do
    it "should change in-journey back to false" do
      # subject.top_up(5)
      # subject.touch_in(station)
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
    it "should deduct from card when touched out" do
      expect { subject.touch_out }.to change{ subject.balance }.by(-2)
    end
  end

  describe "#insufficient funds" do
    it "Gives an error if insufficient funds on card when touch-in" do
      allow(subject).to receive(:balance).and_return(0)
      expect{ subject.touch_in(station) }.to raise_error("Insufficient funds")
    end
  end

end
