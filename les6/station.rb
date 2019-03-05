class Station
  include InstanceCounter 

  attr_reader :trains, :name

  STATION_NAME_FORMAT = /^[A-Z0-9]{2,}((-| )[A-Z0-9]+$|$|(-| )[A-Z0-9]+(-| )[A-Z0-9]+$)/
  
  @@all_stations = []

  def initialize(name)
    @trains = {}
    @name = name
    validate!
    @@all_stations.push(self)
    register_instance
  end

  def self.all
    @@all_stations
  end

  def arrived(train)
    @trains.store(train.number, train.type)
  end

  def type(type)
    number = 0
    @trains.each_value { |value| number += 1 if value == type }
    {"#{type}" => number}
  end

  def departed(train)
    @trains.delete(train.number)
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Некорректное название станции" if name !~ STATION_NAME_FORMAT
    true
  end
end
