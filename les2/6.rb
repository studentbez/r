#сумма покупок
inventar = {}
sum = 0
puts "Для остановки введите stop"
loop do
  print "Введите товар: "
  item = gets.chomp
  break if item == 'stop'
  print "Введите цену за единицу товара: "
  cost = gets.chomp.to_f
  print "Введите количество товара: "
  count = gets.chomp.to_f
  inventar[item] = {"цена": cost, "количество": count} 
  sum += cost * count
end
inventar.each { |key, value| puts "Товар #{key}: #{value}, стоит #{value[:"цена"] * value[:"количество"]}"}
puts "Итого: #{sum}"
