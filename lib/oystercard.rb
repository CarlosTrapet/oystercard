require_relative 'journey'

class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  attr_reader :balance, :entry_station, :exit_station, :journey, :history

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @journey
    @history = []
  end

  def top_up(amount)
    fail "Exceeded top-up maximum amount of #{MAXIMUM_LIMIT}" if amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_LIMIT
    @journey = Journey.new(entry_station = station)
    @history << @journey.details
  end

  def touch_out(station)
    if @journey.nil?
      @journey = Journey.new
      @history << journey.details
    end
    @journey.exit_station = station
    @journey.update_details
    p journey.entry_station
    p journey.exit_station
    # @journey.details[:exit] = station

    @in_journey = false
    @balance -= 2
    # @entry_station = nil
    # @exit_station = station
    # @journey.exit_station = station
    # @journey.store_journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
