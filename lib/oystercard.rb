class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  attr_reader :balance, :in_journey, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    # @entry_station = station
    # @entry_station = ""
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
    @entry_station = station

  end

  def touch_out(station)
    @in_journey = false
    @balance -= 2
    @entry_station = nil
  end


  private
  def deduct(amount)
    @balance -= amount
  end

end
