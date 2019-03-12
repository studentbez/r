class Station
  include InstanceCounter

  attr_reader :trains, :name

  NAME = /^[A-Z0-9]{2,}((-| )[A-Z0-9]+$|$|(-| )[A-Z0-9]+(-| )[A-Z0-9]+$)/.freeze

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

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise 'Некорректное название станции' if name !~ NAME

    true
  end

  def all_trains_on_station
    index = 0
    @trains.each do |train|
      print "#{index += 1} "
      yield train
    end
  end
end
