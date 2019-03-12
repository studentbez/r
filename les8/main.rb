require_relative 'corporation'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'van'
require_relative 'cargo_train'
require_relative 'cargo_van'
require_relative 'passenger_train'
require_relative 'passenger_van'
require_relative 'route'
require_relative 'station'

@stations_list = []
@trains_list = []
@routes_list = []

def menu
  puts "--Для ввода используйте английскую расскладку и заглавные буквы
  --1 Создать станцию\n  --2 Создать поезд\n  --3 Создать маршрут
  --4 Добавить станцию к маршруту\n  --5 Удалить станцию из маршрута
  --6 Назначить маршрут поезду\n  --7 Добавить вагоны к поезду
  --7 Отцепить вагоны от поезда\n  --8 Переместить поезд по маршруту вперед
  --9 Переместить поезд по маршруту назад\n  --10 Занять место или объем
  --11 Cписок станций\n  --12 Cписок поездов
  --13 Cписок поездов на станции\n  --14 Cписок вагонов поезда\n  --0 Выход"
  pick
end

def menu_2(picked)
  case picked
  when 1 then create_station
  when 2 then create_train
  when 3 then ctreate_route
  when 4 then add_station
  when 5 then delete_station
  when 6 then add_route_to_train
  when 7 then attach_van
  when 8 then unhook_van
  when 9 then train_to_next_station
  when 10 then train_to_previous_station
  when 11 then change_vans_value
  when 12 then checklist
  when 13 then show_trains
  when 14 then train_on_station
  when 15 then van_list
  when 0 then exit
  end
  menu
end

def pick
  print 'Введите номер выбранного пункта: '
  picked = gets.chomp.to_i
  menu_2(picked)
end

def create_station
  print 'Введите название станции: '
  name = gets.chomp
  @stations_list.each { |station| error if station.name == name }
  @stations_list.push(Station.new(name))
rescue StandartError => e
  puts e.message
  create_station
end

def create_train
  print 'Введите номер поезда в формате ХХХ-ХХ или ХХХ ХХ: '
  number = gets.chomp
  @trains_list.each { |train| error if train.number == number }
  puts "Выберите его тип:\n1 - Пассажирский;\n2 - Грузовой."
  picked = gets.chomp.to_i
  choise(picked)
rescue StandartError => e
  puts e.message
  create_train
end

def choise(picked)
  if picked == 1
    @trains_list.push(PassengerTrain.new(number))
  elsif picked == 2
    @trains_list.push(CargoTrain.new(number))
  else
    error
  end
end

def ctreate_route
  return puts 'Нужно хотя бы две стании' if @stations_list.count < 2

  checklist
  print 'Введите номер начальной станции: '
  first_station = gets.chomp.to_i
  print 'Введите номер конечной: '
  last_station = gets.chomp.to_i
  list_count = (1..@stations_list.length)
  return error unless list_count.cover?(first_station && last_station) && (first_station != last_station)

  @routes_list.push(Route.new(@stations_list[first_station - 1], @stations_list[last_station - 1]))
end

def van_create
  if @trains_list[@train_number - 1].type == 'Passenger'
    create_passenger_van
  elsif @trains_list[@train_number - 1].type == 'Cargo'
    create_cargo_van
  end
end

def create_passenger_van
  print 'Введите количество мест(от 16 до 54):'
  seats = gets.chomp.to_i
  return error_value unless (16..54).cover?(seats)

  @van = PassengerVan.new(seats)
end

def create_cargo_van
  print 'Введите объем вагона(от 88 до 138):'
  volume = gets.chomp.to_f
  return error_value unless (88.0..138.0).cover?(volume)

  @van = CargoVan.new(volume)
end

def add_station
  route_choise
  checklist
  control
  @routes_list[@route_number - 1].stations.each { |station| error if @stations_list[@number - 1] == station }
  @routes_list[@route_number - 1].add(@stations_list[@number - 1])
end

def delete_station
  route_choise
  return error if @routes_list[@route_number - 1].stations.count == 2

  stations_of_route
  control
  @routes_list[@route_number - 1].delete(@stations_list[@number - 1])
end

def checklist
  if !@stations_list.empty?
    puts 'Список станций:'
    @stations_list.each { |station| puts "#{@stations_list.index(station) + 1} #{station.name}" }
  else
    blank
  end
end

def van_list
  train_choise
  @trains_list[@train_number - 1].all_vans_in_train { |van| puts "No #{van.number} *#{van.type}* Свободно:#{van.place} Занято:#{van.taked_place}" }
end

def stations_of_route
  puts 'Список станций маршрута:'
  @routes_list[@route_number - 1].stations.each { |station| puts "#{@routes_list[@route_number - 1].stations.index(station) + 1} #{station.name}" }
end

def route_choise
  if !@routes_list.empty?
    puts 'Выберите и введите номер маршрута: '
    @routes_list.each { |value| puts "#{@routes_list.index(value) + 1}) #{value.list}" }
    @route_number = gets.chomp.to_i
    error unless (1..@routes_list.length).cover?(@route_number)
  else
    blank
  end
end

def control
  print 'Введите номер станции: '
  @number = gets.chomp.to_i
  error unless (1..@stations_list.length).cover?(@number)
end

def add_route_to_train
  train_choise
  route_choise
  @trains_list[@train_number - 1].add_route(@routes_list[@route_number - 1])
end

def attach_van
  train_choise
  van_create
  @trains_list[@train_number - 1].attach(@van)
end

def unhook_van
  train_choise
  @trains_list[@train_number - 1].unhook
end

def train_to_next_station
  train_choise
  return error_move if @trains_list[@train_number - 1].move_forward.nil?

  @trains_list[@train_number - 1].move_forward
end

def train_to_previous_station
  train_choise
  return error_move if @trains_list[@train_number - 1].move_back.nil?

  @trains_list[@train_number - 1].move_back
end

def train_on_station
  checklist
  print 'Введите номер станции: '
  number = gets.chomp.to_i
  return error unless (1..@stations_list.length).cover?(number)

  puts 'Список поездов на станции: '
  @stations_list[number - 1].all_trains_on_station { |train| puts "Поезд: #{train.number} Кол-во вагонов: #{train.vans.count}" }
end

def train_choise
  show_trains
  print 'Выберите номер поезда: '
  @train_number = gets.chomp.to_i
  error unless (1..@trains_list.length).cover?(@train_number)
end

def show_trains
  if !@trains_list.empty?
    @trains_list.each { |value| puts "#{@trains_list.index(value) + 1}) #{value.number} *#{value.type}*" }
  else
    blank
  end
end

def change_vans_value
  van_list
  print 'Выберите вагон:'
  van_index = gets.chomp.to_i
  return error unless (1..@trains_list[@train_number - 1].vans.length).cover?(van_index)

  if @trains_list[@train_number - 1].type == 'Passenger'
    @trains_list[@train_number - 1].vans[van_index - 1].take_seat
  elsif @trains_list[@train_number - 1].type == 'Cargo'
    print 'Введите занимаемый объем:'
    volume = gets.chomp.to_f
    return error_value unless (0..138.0).cover?(volume)

    @trains_list[@train_number - 1].vans[van_index - 1].take_volume(volume)
  end
end

def blank
  puts '!!Список пуст!!'
  menu
end

def error
  puts '!!Ошибка!!'
  menu
end

def error_move
  puts 'Конечная. Поезд дальше не идет.'
  menu
end

def error_value
  puts '!!Неверное значение!!'
  menu
end

menu
