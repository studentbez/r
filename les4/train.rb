class Train
  attr_reader :speed, :name, :station_index, :station, :route, :vans, :type

  def initialize(name)
    @name = name
    @vans = []
    @speed = 0
    @type = type
  end

  def speed_gather
    @speed += 5
  end

  def stop
    @speed = 0
  end

  def attach(van)
    wrong_move
    @vans << van if self.speed == 0
  end

  def unhook
    wrong_move
    @vans.delete_at(-1) if self.speed == 0 && @vans.count > 1
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

  def move_forward
    if next_station
      self.station = next_station
      self.train_way
      self.station_index += 1
    else
      puts "Конечная. Поезд дальше не идет."
    end
  end

  def move_back
    if previous_station
      self.station = previous_station
      self.train_way
      self.station_index -= 1
    else
      puts "Конечная. Поезд дальше не идет."
    end
  end

  protected

  attr_writer :speed, :name, :station_index, :station, :route, :vans, :type
  #Потому что нам не нужно чтобы пользователь имел возможность изменять их 
  #саомстоятельно, используя произвольные зхначения, 

  def wrong_move#этот метод не нужен пользователю для вызова, и используется локально
    return puts "Сначала остановите поезд."  if @speed > 0
  end

  def train_way#аналогично верхнему
    self.station.arrived(self)
    self.route.stations[self.station_index].departed(self)
  end
end
