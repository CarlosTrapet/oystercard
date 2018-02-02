require_relative 'journey'

class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  attr_reader :balance, :journey, :history

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

  # def in_journey?
  #   !!entry_station
  # end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_LIMIT

    if !@history.empty?
      deduct(@history.last.fare) unless @history.last.complete? || @history.last.paid
    end
    @journey = Journey.new(entry_station = station)
    @journey.update_details
    @history << @journey
  end

  def touch_out(station)
    if @journey.nil?
      @journey = Journey.new
      @history << journey
    end
    @journey.exit_station = station
    @journey.update_details
    deduct(@journey.fare)
    # @entry_station = nil
    # @exit_station = station
    # @journey.exit_station = station
    # @journey.store_journey
  end

  private
  def deduct(amount)
    @balance -= amount
    @journey.paid = true
  end



end
