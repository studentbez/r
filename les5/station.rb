class Station
  include InstanceCounter

  attr_reader :trains, :name
  
  @@all_stations = []

  def initialize(name)
    @trains = {}
    @name = name
    @@all_stations.push(self)
    register_instance
  end

  def self.all
    @@all_stations
  end

  def arrived(train)
    @trains.store(train.name, train.type)
  end

  def type(type)
    number = 0
    @trains.each_value { |value| number += 1 if value == type }
    {"#{type}" => number}
  end

  def departed(train)
    @trains.delete(train.name)
  end
end
