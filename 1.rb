#Yukhin programma "idealnii ves"
print "Введите ваше имя: "
name = gets.chomp.capitalize!
print "Введите ваш рост: "
ideal_weight = gets.chomp.to_i - 110
puts "#{name}, Ваш вес уже оптимален." if ideal_weight <= 0
puts "#{name}, ваш идеальный вес #{ideal_weight}." if ideal_weight > 0
