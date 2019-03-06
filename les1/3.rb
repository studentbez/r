#Yukhinni "pryamougolnii treugolnik"
puts "Введите три стороны треугольника:"
side = []
for i in (1..3)
	print "#{i} сторона = "
	side << gets.chomp.to_f
end
side = side.sort
max = side[2]
cat1 = side[1]
cat2 = side[0]
if (max ** 2 == cat1 ** 2 + cat2 ** 2)
	puts "треугольник прямоугольный."
elsif (max == cat1) && (cat1 == cat2)
	puts "треугольник равнобедренный и равносторонний."
elsif  (max ** 2 == cat1 ** 2 + cat2 ** 2) && ((max == cat1) || (max == cat2) || (cat2 == cat1))
	puts "треугольник прямоугольный и равнобедренный."
else
	puts "треугольник не прямоугольный."
end
