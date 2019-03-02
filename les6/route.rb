class Route 
  include InstanceCounter
  
  attr_reader :stations
  
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
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

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Некорректный тип станции" if !station_valid(@stations.first) && !station_valid(@stations.last)
    true
  end

  def station_valid(station)
    station.class == Station
  end
end
