class Train
  attr_accessor :speed, :count, :name, :type, :station_index, :station, :route

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
    @count -= 1 if @speed == 0 && @count > 1
    puts "Поезд движется. Вагон нельзя отцепить." if @speed > 0
  end

  def add_route(route)
    @route = route
    self.station = self.route.stations[0]
    self.station_index = self.route.stations.index(self.station)
    self.station.arrived(self)
  end

  def next_station
    if self.route.stations[self.station_index + 1]
      self.route.stations[self.station_index + 1]
    end
  end

  def previous_station
    if self.station_index - 1 >= 0
     self.route.stations[self.station_index - 1]
    end
  end

  def train_way
    self.station.arrived(self)
    self.route.stations[self.station_index].departed(self)
  end

  def move_forward
    if next_station
      self.station = next_station #self.route.stations[self.station_index + 1]
      self.train_way
      self.station_index += 1
    else
      puts "Конечная. Поезд дальше не идет."
    end
  end

  def move_back
    if previous_station
      self.station = previous_station #self.route.stations[self.station_index - 1]
      self.train_way
      self.station_index -= 1
    else
      puts "Конечная. Поезд дальше не идет."
    end
  end
end
