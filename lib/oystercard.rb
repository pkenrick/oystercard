require_relative 'journey'

class Oystercard

  attr_reader :balance
  attr_reader :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Balance can't exceed 90" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station, journey=Journey.new(station))
    raise "Already in a journey" if in_journey?
    raise "Not enough funds" if balance < MINIMUM_BALANCE
    @journeys << journey
    @journeys.last
    # @journeys << {:entry_station => station}
  end

  def touch_out(station_name,station=Station.new(station_name))
    raise "Not yet started journey" if in_journey? == false
    deduct(MINIMUM_FARE)
    @journeys.last.set_exit(station_name,station)
    @journeys.last
  end

  def in_journey?
    return false if @journeys.empty?
    return @journeys.last.exit_station == nil ? true : false
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
