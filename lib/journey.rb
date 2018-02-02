require_relative 'oystercard'

class Journey

  attr_accessor :entry_station, :exit_station, :paid
  attr_reader :details

  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @details = {}
    @paid = false
  end

  def update_details
    @details[:entry] = @entry_station
    @details[:exit] = @exit_station
  end
  # def store_journey
  #   @history << { :entry => @entry_station, :exit => @exit_station }
  # end

  def complete?
    !!@entry_station && !!@exit_station
  end

  def fare
    self.complete? ? MINIMUM_FARE : PENALTY_FARE
  end
end
