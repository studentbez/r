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
  puts "--Для ввода используйте английскую расскладку и заглавные буквы--
  --1 Создать станцию--
  --2 Создать поезд--
  --3 Создать маршрут--
    --3.1 Добавить станцию--
    --3.2 Удалить станцию--
  --4 Назначить маршрут поезду--
  --5 Добавить вагоны к поезду--
  --6 Отцепить вагоны от поезда--
    --7.1 Переместить поезд по маршруту вперед--
    --7.2 Переместить поезд по маршруту назад--
  --8 Просмотреть список станций--
    --9.1 Просмотреть список поездов--
    --9.2 Просмотреть список поездов на станции--
  --0 Выход--"
  print "Введите номер выбранного пункта: "
  picked = gets.chomp
  menu_2(picked)
end

def menu_2(picked)
  case picked
  when "1" then create_station
  when "2" then create_train
  when "3" then ctreate_route
  when "3.1" then add_station 
  when "3.2" then delete_station 
  when "4" then add_route_to_train 
  when "5" then attach_van
  when "6" then unhook_van 
  when "7.1" then train_to_next_station 
  when "7.2" then train_to_previous_station
  when "8" then checklist
  when "9.1" then show_trains
  when "9.2" then train_on_station
  when "0" then return exit
  end 
  menu
end

def create_station
  print "Введите название станции: "
  name = gets.chomp
  @stations_list.each { |station| error if station.name == name }
  @stations_list.push(Station.new(name))
rescue Exception => e
  puts e.message
  create_station
end

def create_train
  print "Введите номер поезда в формате ХХХ-ХХ или ХХХ ХХ: "
  number = gets.chomp
  @trains_list.each { |train|  error if (train.number == number)}
  puts "Выберите его тип:
    1 - Пассажирский;
    2 - Грузовой."
  picked = gets.chomp.to_i
  if picked == 1
    @trains_list.push(PassengerTrain.new(number))
  elsif picked == 2
    @trains_list.push(CargoTrain.new(number))
  else
    error
  end
rescue Exception => e
  puts e.message
  create_train
end

def ctreate_route
  return puts "Чтобы создать маршрут, нужно хотя бы две стании" if @stations_list.count < 2
  checklist
  print "Введите номер начальной станции: "
  first_station = gets.chomp.to_i
  print "Введите номер конечной: "
  last_station = gets.chomp.to_i 
  check = (1..@stations_list.length).include?(first_station) && (1..@stations_list.length).include?(last_station) && (first_station != last_station) 
  if check
    @routes_list.push(Route.new(@stations_list[first_station - 1], @stations_list[last_station - 1]))
  else
    error
  end
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
    puts "Список станций:"
    @stations_list.each { |station| puts "#{@stations_list.index(station) + 1} #{station.name}" }
  else
    blank
  end
end

def stations_of_route
  puts "Список станций маршрута:"
  @routes_list[@route_number - 1].stations.each { |station| puts "#{@routes_list[@route_number - 1].stations.index(station) + 1} #{station.name}" }
end

def route_choise
  if !@routes_list.empty?
    puts "Выберите и введите номер маршрута: "
    @routes_list.each { |value| puts "#{@routes_list.index(value) + 1}) #{value.list}" }
    @route_number = gets.chomp.to_i
    error if !(1..@routes_list.length).include?(@route_number)
  else
    blank
  end
end

def control
  print "Введите номер станции: "
  @number = gets.chomp.to_i
  error if !(1..@stations_list.length).include?(@number)
end

def add_route_to_train
  train_choise
  route_choise
  @trains_list[@train_number - 1].add_route(@routes_list[@route_number - 1])
end 

def attach_van
  train_choise
  van = PassengerVan.new() if @trains_list[@train_number - 1].type == "Passenger"
  van = CargoVan.new() if @trains_list[@train_number - 1].type == "Cargo"
  @trains_list[@train_number - 1].attach(van)
end

def unhook_van
  train_choise
  @trains_list[@train_number - 1].unhook
end

def train_to_next_station
  train_choise
  @trains_list[@train_number - 1].move_forward
end

def train_to_previous_station
  train_choise
  @trains_list[@train_number - 1].move_back
end

def train_on_station
  checklist
  print "Введите номер станции: "
  number = gets.chomp.to_i
  return error if !(1..@stations_list.length).include?(number)
  puts "Список поездов на станции: "
  puts @stations_list[number - 1].trains
end

def train_choise
  show_trains
  puts "Выберите номер поезда: "
  @train_number = gets.chomp.to_i
  error if !(1..@trains_list.length).include?(@train_number)
end

def show_trains
  if !@trains_list.empty?
    @trains_list.each { |value| puts "#{@trains_list.index(value) + 1}) #{value.number} *#{value.type}*"}
  else
    blank
  end
end

def blank
  puts "!!Список пуст!!"
  menu
end

def error
  puts "!!Ошибка!!"
  menu
end

menu
