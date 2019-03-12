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
    @stations.collect(&:name)
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise 'Некорректный тип станции' if @stations.any? { |s| unequal(s) }
    raise 'Станций должно быть >= 2' if @stations.count < 2

    true
  end

  def unequal(station)
    station.class != Station
  end
end
