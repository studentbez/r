class Station
  attr_reader :trains, :name

  def initialize(name)
    @trains = {}
    @name = name
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
