class Station
  attr_reader :trains

  def initialize(name)
    @trains = {}
    @name = name
  end

  def arrived(train, type)
    @trains.store(train, type)
  end

  def type(type)
    number = 0
    @trains.each_value { |value| number += 1 if value == type }
    return "Станция '#{@name}': поездов типа '#{type}' - #{number}."
  end

  def departed(train)
    @trains.delete(train)
  end
end
