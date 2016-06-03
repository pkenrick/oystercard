require_relative 'journey'
require_relative 'journeylog'

class Oystercard

	attr_reader :balance, :entry_station, :journeys, :journeylog

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

	def initialize(journeylog_class = JourneyLog)
    @journeylog = journeylog_class.new
		@balance = 0
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
    deduct(fare(journeylog.current_journey)) if journeylog.unfinished_journeys?
    journeylog.start(entry_station)
  end

  def touch_out(exit_station)
    journeylog.unitialized_journeys?
    journeylog.finish(exit_station)
    deduct(fare(journeylog.current_journey))
  end

  def fare(journey)
    if journeylog.current_journey.entry_station.name == "no tap in" || 
       journey.exit_station.name == "no tap out"
        return PENALTY_FARE 
    else
      return MINIMUM_FARE
    end
  end

  def history
    journeylog.journeys
  end

  private

  def check_funds
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end

# oyster = Oystercard.new
# oyster.top_up(10)
# p "Balance is now: #{oyster.balance}"
# oyster.touch_in("Bank")
# oyster.touch_out("Aldgate")
# p "Card has touched in and out correctly.  Balance is now: #{oyster.balance}"
# oyster.touch_out("Aldgate")
# p "Skipped the tap in, and now tapped out at Aldgate.  A penalty fare should be charged."
# p "Card balance is now: #{oyster.balance}"






