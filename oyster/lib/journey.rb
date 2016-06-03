require_relative 'station'

class Journey

attr_reader :entry_station, :exit_station

  def initialize(station_name)
    @entry_station = Station.new(station_name)
  end

  def set_exit(station_name)
    @exit_station = Station.new(station_name)
  end

  def initiate_journey
    @single_journey = []
  end

end