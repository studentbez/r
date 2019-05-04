require_relative 'corporation'
require_relative 'accessors'
require_relative 'validation'
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
  --00 VALID TEST
  --1 Создать станцию\n  --2 Создать поезд\n  --3 Создать маршрут
  --4 Добавить станцию к маршруту\n  --5 Удалить станцию из маршрута
  --6 Назначить маршрут поезду\n  --7 Добавить вагоны к поезду
  --8 Отцепить вагоны от поезда\n  --9 Переместить поезд по маршруту вперед
  --10 Переместить поезд по маршруту назад\n  --11 Занять место или объем
  --12 Cписок станций\n  --13 Cписок поездов
  --14 Cписок поездов на станции\n  --15 Cписок вагонов поезда\n  --0 Выход"
  print 'Введите номер выбранного пункта: '
  picked = gets.chomp.to_i
  menu_2(picked)
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
  when 00 then valid_test
  when 0 then exit
  end
end

def valid_test
  puts "\n  --1 valid train name
  --2 valid train type
  --3 valid route
  --4 valid station name
  --5 valid type of class"
  pick = gets.chomp.to_i
  case pick
  when 1 then Train.new("fk k", "Cargo")
  when 2 then Train.new("23F BB", "blabla")
  when 3 then Route.new("", "")
  when 4 then Station.new("moskva")
  when 5 then Train.new("23F MF", 34)
  end
end

def create_station
  print 'Введите название станции: '
  name = gets.chomp
  @stations_list.each { |station| error if station.name == name }
  @stations_list.push(Station.new(name))
  create_station
end

def create_train
  print 'Введите номер поезда в формате ХХХ-ХХ или ХХХ ХХ: '
  number = gets.chomp
  @trains_list.each { |train| error if train.number == number }
  puts "Выберите его тип:\n1 - Пассажирский;\n2 - Грузовой."
  picked = gets.chomp.to_i
  choise(picked)
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

def checklist
  if @stations_list.empty?
    blank
  else
    puts 'Список станций:'
    @stations_list.each do |station|
      puts "#{@stations_list.index(station) + 1} #{station.name}"
    end
  end
end

def ctreate_route
  return puts 'Нужно хотя бы две стании' if @stations_list.count < 2

  checklist
  number_of_station
  list_count = (1..@stations_list.length)
  rule = list_count.cover?(@sta + 1 && @fin + 1) && (@sta + 1 != @fin + 1)
  return error unless rule

  @routes_list.push(Route.new(@stations_list[@sta], @stations_list[@fin]))
end

def number_of_station
  print 'Введите номер начальной станции: '
  @sta = gets.chomp.to_i
  print 'Введите номер конечной: '
  @fin = gets.chomp.to_i
  @sta -= 1
  @fin -= 1
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
  station = @stations_list[@number - 1]
  @routes_list[@route_number - 1].stations.each { |s| error if station == s }
  @routes_list[@route_number - 1].add(@stations_list[@number - 1])
end

def delete_station
  route_choise
  return error if @routes_list[@route_number - 1].stations.count == 2

  stations_of_route
  control
  @routes_list[@route_number - 1].delete(@stations_list[@number - 1])
end

def van_list
  train_choise
  @trains_list[@train_number - 1].all_vans_in_train do |van|
    print "No #{van.number}*"
    print " #{van.type}"
    print " *Свободно:#{van.place}"
    print " Занято:#{van.taked_place}\n"
  end
end

def stations_of_route
  puts 'Список станций маршрута:'
  @routes_list[@route_number - 1].stations.each do |station|
    print @routes_list[@route_number - 1].stations.index(station) + 1
    print " #{station.name}\n"
  end
end

def route_choise
  if @routes_list.empty?
    blank
  else
    puts 'Выберите и введите номер маршрута: '
    @routes_list.each do |value|
      puts "#{@routes_list.index(value) + 1}) #{value.list}"
    end
    @route_number = gets.chomp.to_i
    error unless (1..@routes_list.length).cover?(@route_number)
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

def train_next_station
  train_choise
  return error_move if @trains_list[@train_number - 1].move_forward.nil?

  @trains_list[@train_number - 1].move_forward
end

def train_previous_station
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
  @stations_list[number - 1].all_trains_on_station do |train|
    puts "Поезд: #{train.number} Кол-во вагонов: #{train.vans.count}"
  end
end

def train_choise
  show_trains
  print 'Выберите номер поезда: '
  @train_number = gets.chomp.to_i
  error unless (1..@trains_list.length).cover?(@train_number)
end

def show_trains
  if !@trains_list.empty?
    @trains_list.each do |value|
      puts "#{@trains_list.index(value) + 1}) #{value.number} *#{value.type}*"
    end
  else
    blank
  end
end

def change_vans_value
  van_list
  print 'Выберите вагон:'
  @van_index = gets.chomp.to_i
  rule = (1..@trains_list[@train_number - 1].vans.length).cover?(@van_index)
  return error unless rule

  if @trains_list[@train_number - 1].type == 'Passenger'
    @trains_list[@train_number - 1].vans[@van_index - 1].take_seat
  elsif @trains_list[@train_number - 1].type == 'Cargo'
    cargo_van
  end
end

def cargo_van
  print 'Введите занимаемый объем:'
  volume = gets.chomp.to_f
  return error_value unless (0..138.0).cover?(volume)

  @trains_list[@train_number - 1].vans[@van_index - 1].take_volume(volume)
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
