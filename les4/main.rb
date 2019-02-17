require_relative 'train'
require_relative 'cargo_train'
require_relative 'cargo_van'
require_relative 'passenger_train'
require_relative 'passenger_van'
require_relative 'route'
require_relative 'station'

@stations_list = []
@trains_list = []
@route = []

def menu
  puts "1 Создать станцию
  -----------------
  2 Создать поезд
  -----------------
  3 Создать маршрут
  -----------------
    3.1 Добавить станцию
    -----------------
    3.2 Удалить станцию
    -----------------
  4 Назначить маршрут поезду
  -----------------
  5 Добавить вагоны к поезду
  -----------------
  6 Отцепить вагоны от поезда
  -----------------
    7.1 Переместить поезд по маршруту вперед
    -----------------
    7.2 Переместить поезд по маршруту назад
    -----------------
  8 Просмотреть список станций
  -----------------
  9 Просмотреть список поездов на станции
  -----------------
  0 Выход
  -----------------"
  print "Введите номер выбранного пункта: "
  picked = gets.chomp
  menu_2(picked)
end

def menu_2(picked)
  case picked
  when "1" then create_station#+ станция
  when "2" then create_train #+ поезд
  when "3" then ctreate_route #создать маршрут
  when "3.1" then add_station #+станция
  when "3.2" then delete_station #- станция
  when "4" then add_route_to_train #назначить маршрут
  when "5" then attach_van #+вагон
  when "6" then unhook_van #-вагон
  when "7.1" then train_to_next_station #-1 по маршруту
  when "7.2" then train_to_previous_station #поезд + 1 по маршруту
  when "8" then checklist #список станций
  when "9" then train_on_station#список поездов на станции
  when "0" then return
  end 
  menu
end

def create_station
  puts "Введите название станции: "
  name = gets.chomp
  @stations_list.push(Station.new(name))
end

def create_train
  print "Введите название поезда: "
  name = gets.chomp
  puts "Выберите его тип:
    1 - Пассажирский;
    2 - Грузовой."
  picked =  gets.chomp.to_i
  @trains_list.push(Passenger_train.new(name)) if picked == 1
  @trains_list.push(Cargo_train.new(name)) if picked == 2
end

def ctreate_route
  return puts "Чтобы создать маршрут, нужно хотя бы две стании" if @stations_list.count < 2
  checklist
  print "Введите номер начальной станции: "
  first_station = gets.chomp.to_i
  print "Введите номер конечной: "
  last_station = gets.chomp.to_i
  if (first_station == last_station) || (first_station > @stations_list.length) || (last_station > @stations_list.length)
    puts "Ошибка"
    return ctreate_route
  else
    @route.push(Route.new(@stations_list[first_station], @stations_list[last_station]))
  end
end

def add_station
  move_with_route
  @route[@route_number].add(@stations_list[@station_number])
end

def delete_station
  move_with_route
  @route[@route_number].delete(@stations_list[@station_number])
end

def add_route_to_train
  train_choise
  route_choise
  @trains_list[@train_number].add_route(@route[@route_number])
end 

def attach_van
  train_choise
  van = Passenger_van.new() if @trains_list[@train_number].type == "Пассажирский"
  van = Cargo_van.new() if @trains_list[@train_number].type == "Грузовой"
  @trains_list[@train_number].attach(van)
end

def unhook_van
  train_choise
  @trains_list[@train_number].unhook
end

def train_to_next_station
  train_choise
  @trains_list[@train_number].move_forward
end

def train_to_previous_station
  train_choise
  @trains_list[@train_number].move_back
end

def checklist
  if !@stations_list.empty?
    puts "Список станций:"
    @stations_list.each { |station| puts "#{@stations_list.index(station)}) #{station.name}" }
  else
    puts "Список станций пуст"
  end
end

def train_on_station
  checklist
  print "Введите номер станции: "
  number = gets.chomp.to_i
  puts "Список поездов на станции: "
  puts @stations_list[number].trains
end

def move_with_route
  route_choise
  if @route.include?(@route[@route_number])
    checklist
    print "Введите номер станции: "
    @station_number = gets.chomp.to_i
  else
    puts "Неверное значение"
    move_with_route
  end
end

def route_choise
  if !@route.empty?
    puts "Выберите и введите номер маршрута: "
    @route.each { |value| puts "#{@route.index(value)}) #{value.list}" }
    @route_number = gets.chomp.to_i
  else
    puts "Список маршрутов пуст"
  end
end

def train_choise
  if !@trains_list.empty?
    puts "Выберите номер поезда: "
    @trains_list.each { |value| puts "#{@trains_list.index(value)}) #{value.name}"}
    @train_number = gets.chomp.to_i
  else
    puts "Список поездов пуст"
  end
end

menu
