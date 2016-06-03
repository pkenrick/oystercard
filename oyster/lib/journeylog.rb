class JourneyLog

attr_reader :journeys

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station_name, journey=Journey.new(station_name))
  	journey
  end

end

journeylog = JourneyLog.new(:journey1)
p journeylog
p "hello"