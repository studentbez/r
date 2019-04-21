class Route
  include InstanceCounter
  include Validation
  extend Accessor

  attr_reader :stations
  validate :first, :presence
  validate :first, :type, Station
  validate :last, :presence
  validate :last, :type, Station


  def initialize(first_station, last_station)
    @first = first_station
    @last = last_station
    @stations = [first, last]
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
    @stations.collect(&:name)
  end
end
