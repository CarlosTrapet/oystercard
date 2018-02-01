require_relative 'oystercard'

class Journey

  attr_accessor :entry_station, :exit_station
  attr_reader :history

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @history = []
  end

  def store_journey
    @history << { :entry => @entry_station, :exit => @exit_station }
  end

end
