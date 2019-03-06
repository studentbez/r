#Yukhin programma "Ploshad treugolnika"
puts "Введите длину основания и высоту треугольника: "
print "длина = "
lenght = gets.chomp.to_f
print "высота = "
height = gets.chomp.to_f
square = 0.5 * lenght * height
puts "Площадь треугольника #{square}."
