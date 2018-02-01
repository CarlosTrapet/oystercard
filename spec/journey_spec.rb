require 'journey'

describe Journey do 

  it { is_expected.to respond_to(:start_journey).with(1).argument }

end