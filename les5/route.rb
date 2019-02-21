class Route
  include InstanceCounter
  
  attr_reader :stations
  
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station)
  end

  def list
    @stations.collect { |station| station.name }
  end
end
