class Train
  attr_reader :speed, :count, :route
  attr_accessor :station

  def initialize(name, type, count)
    @name = name
    @type = type
    @count = count
    @speed = 0
  end

  def speed_gather
    @speed += 5
  end

  def stop
    @speed = 0
  end

  def attach
    @count += 1 if @speed == 0
    puts "Поезд движется. Вагон нельзя прицепить." if @speed > 0
  end

  def unhook
    @count -= 1 if @speed == 0
    puts "Поезд движется. Вагон нельзя отцепить." if @speed > 0
  end

  def add_route(route)
    @route = route
    self.station = self.route.stations[0]
  end

  def next_station
    self.station = self.route.stations[self.route.stations.index(self.station) + 1]
  end

  def previous_station
    self.station = self.route.stations[self.route.stations.index(self.station) - 1]
  end

  def segment_of_route
    { "Предыдущая станция" => self.route.stations[self.route.stations.index(self.station) - 1],
      "Текущая станция" => self.route.stations[self.route.stations.index(self.station)],
      "Следующая станция" => self.route.stations[self.route.stations.index(self.station) + 1] }
  end
end