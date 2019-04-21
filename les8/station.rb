class Station
  include InstanceCounter
  include Validation
  extend Accessor

  attr_reader :trains, :name
  validate :name, :format, /^[A-Z0-9]{2,}((-| )[A-Z0-9]+$|$|(-| )[A-Z0-9]+(-| )[A-Z0-9]+$)/ 

  def initialize(name)
    @trains = []
    @name = name
    validate!
    @all_stations.push(self)
    register_instance
  end

  def self.all
    @all_stations
  end

  def all_stations
    @all_stations = []
  end

  def arrived(train)
    @trains.push(train)
  end

  def type(type)
    number = 0
    @trains.each { |value| number += 1 if value.type == type }
    { type.to_s => number }
  end

  def departed(train)
    @trains.delete(train.number)
  end

  def all_trains_on_station
    index = 0
    @trains.each do |train|
      print "#{index += 1} "
      yield train
    end
  end
end

bad = Station.new("moskva")
p Station.instance_methods
p Station.attr_accessor_with_history(:arg1, :arg2)
p Station.strong_attr_accessor(:arg3, Station)
