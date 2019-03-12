class Train
  include Corporation
  include InstanceCounter

  attr_reader :speed, :station_index, :station, :route, :vans, :type, :number

  TRAIN_NUMBER_FORMAT = /^[A-Z0-9]{3}(-| )[A-Z0-9]{2}$/.freeze
  TRAIN_TYPE = /^(Passenger|Cargo)$/.freeze

  def initialize(number, type)
    @number = number
    @vans = []
    @speed = 0
    @type = type
    validate!
    @trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def trains
    @trains = {}
  end

  def speed_gather
    @speed += 5
  end

  def stop
    @speed = 0
  end

  def attach(van)
    wrong_move
    @vans << van if speed.zero?
  end

  def unhook
    wrong_move
    @vans.delete_at(-1) if speed.zero? && @vans.count > 1
  end

  def add_route(route)
    @route = route
    self.station = self.route.stations[0]
    self.station_index = self.route.stations.index(station)
    station.arrived(self)
  end

  def next_station
    route.stations[station_index + 1]
  end

  def previous_station
    route.stations[station_index - 1] if station_index - 1 >= 0
  end

  def move_forward
    return unless next_station

    self.station = next_station
    train_way
    self.station_index += 1
  end

  def move_back
    return unless previous_station

    self.station = previous_station
    train_way
    self.station_index -= 1
  end

  def all_vans_in_train
    index = 0
    @vans.each do |van|
      print "#{index += 1} "
      yield van
    end
  end

  protected

  attr_writer :speed, :station_index, :station, :route, :vans, :type, :number

  def wrong_move
    return puts 'Сначала остановите поезд.' if @speed > 0
  end

  def train_way
    station.arrived(self)
    route.stations[self.station_index].departed(self)
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def validate!
    raise 'Некорректный номер' if number !~ TRAIN_NUMBER_FORMAT
    raise 'Неккоректный тип поезда' if type !~ TRAIN_TYPE

    true
  end
end
