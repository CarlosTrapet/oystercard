require_relative 'oystercard'

class Journey

  attr_accessor :entry_station, :exit_station
  attr_reader :details

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @details = {}
  end

  def update_details
    @details[:entry] = @entry_station
    @details[:exit] = @exit_station
  end
  # def store_journey
  #   @history << { :entry => @entry_station, :exit => @exit_station }
  # end

end
