require_relative 'journey'
require_relative 'journeylog'

class Oystercard

	attr_reader :balance, :entry_station, :journeys, :journeylog



  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

	def initialize
    #@journeylog = JourneyLog.new
		@balance = 0
    @journeys = []
	end

	def top_up(amount)
		fail "Can't add to your balance; would breach the £90 limit" if limit_reached?(amount)
		@balance += amount

	end

	def limit_reached?(amount)
		@balance + amount > MAXIMUM_BALANCE
	end

  def touch_in(entry_station)
    fail 'Insufficient funds for journey' if check_funds
    close_bad_journeys
    @journeys << Journey.new(entry_station)
  end

  def touch_out(exit_station)
    close_unitialized_journeys
    @journeys.last.set_exit(exit_station)
    deduct(fare(@journeys.last))
  end

  def close_bad_journeys
    if in_journey?
      @journeys.last.set_exit("no check-in")
      deduct(fare(@journeys.last))
    end
  end

  def close_unitialized_journeys
      @journeys << Journey.new("no check-in") if !in_journey?
  end

  def fare(journey)
    return PENALTY_FARE if journey.entry_station.name == "no check-in" || journey.exit_station.name == "no check-in"
    MINIMUM_FARE
  end

  def in_journey?
     return @journeys.last.entry_station != nil && @journeys.last.exit_station == nil if @journeys != []
      false
  end

  def journeys
    @journeys
  end


  private

  def check_funds
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end

oyster = Oystercard.new
oyster.top_up(10)
oyster.touch_in("Bank")
oyster.touch_out("Aldgate")
p oyster.journeys
p oyster.balance
oyster.touch_out("Bank")
p oyster.balance




