require_relative 'journey'

class JourneyLog

attr_reader :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station_name)
    journeys << @journey_class.new(station_name)
    current_journey
  end

  def current_journey
    journeys.last
  end

  def finish(station_name)
    current_journey.set_exit(station_name)
  end

  def unfinished_journeys?
    in_journey? ? current_journey.set_exit("no tap out") != nil : false
  end

  def unitialized_journeys?
    !in_journey? ? start("no tap in") != nil : false
  end

  def in_journey?
      return current_journey.entry_station != nil && current_journey.exit_station == nil if !journeys.empty?
      false
  end

end


