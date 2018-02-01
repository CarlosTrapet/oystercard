require_relative 'oystercard'

class Journey

def initialize
  @history = []
end

attr_reader :history

def store_journey
  @history << { :entry => @entry_station, :exit => @exit_station }
end

# def start_journey(station)
#   # @entry_station = station
# end

end
