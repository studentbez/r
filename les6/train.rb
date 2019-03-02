class Train
  include Corporation
  include InstanceCounter

  attr_reader :speed, :station_index, :station, :route, :vans, :type, :number

  TRAIN_NUMBER_FORMAT = /^[A-Z0-9]{3}(-| )[A-Z0-9]{2}$/
  TRAIN_TYPE = /^(Passenger|Cargo)$/

  @@trains = {}

  def initialize(number, type)
    @number = number
    @vans = []
    @speed = 0
    @type = type
    @@trains[number] = self
    validate!
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def speed_gather
    @speed += 5
  end

  def stop
    @speed = 0
  end

  def attach(van)
    wrong_move
    @vans << van if self.speed.zero? #== 0
  end

  def unhook
    wrong_move
    @vans.delete_at(-1) if self.speed.zero? && @vans.count > 1
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

  attr_writer :speed, :station_index, :station, :route, :vans, :type, :number
 
  def wrong_move
    return puts "Сначала остановите поезд."  if @speed > 0
  end

  def train_way
    self.station.arrived(self)
    self.route.stations[self.station_index].departed(self)
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Некорректный номер" if number !~ TRAIN_NUMBER_FORMAT
    raise "Неккоректный тип поезда" if type !~ TRAIN_TYPE
    true
  end
end
