require_relative 'journey'

class JourneyLog

attr_reader :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station_name)
  	@journeys << @journey_class.new(station_name)
  end

  def finish(station_name)
    @journeys.last.set_exit(station_name)
  end

end


journeylog = JourneyLog.new
journeylog.start("Bank")
p journeylog.journeys.last
