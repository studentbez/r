class Train
  attr_reader :speed, :count, :train_name, :type, :station_index, :station

  def initialize(name, type, count)
    @train_name = name
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
    return "add_route true"
  end

  def next_station
    if self.route.stations[self.station_index + 1]
      puts self.route.stations[self.station_index + 1].name
    else
      puts "#{self.station.name} конец маршрута."
    end
  end

  def previous_station
    if self.station_index - 1 >= 0
      puts self.route.stations[self.station_index - 1].name
    else
      puts "#{self.station.name} начало маршрута."
    end
  end

  def train_way
    self.station.arrived(self)
    self.route.stations[self.station_index].departed(self)
  end

  def move(direction)
    if (direction == "+") && (self.route.stations[self.station_index + 1] != nil)
      self.station = self.route.stations[self.station_index + 1]
      self.train_way
      self.station_index += 1
    elsif (direction == "-") && (self.station_index - 1 >= 0)
      self.station = self.route.stations[self.station_index - 1]
      self.train_way
      self.station_index -= 1
    else
      puts "Конечная. Поезд дальше не идет."
    end
  end
end
