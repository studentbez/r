#Yukhinni "kvadratnoe uravnenie"
require 'mathn' #добавляем, иначе ошибка DomainError при вычислении отрицательного дискриминанта
puts "Введиет коэффициенты уравнения ax^2+bx+c=0: "
print "a= "
a = gets.chomp.to_f
print "b= "
b = gets.chomp.to_f
print "c= "
c = gets.chomp.to_f
d = b * b - 4 * a * c
if d > 0
  x1 = (- b + Math.sqrt(d)) / (2 * a)
  x2 = (- b - Math.sqrt(d)) / (2 * a)
	puts "Дискриминант = #{d}, x1 = #{x1}, x2 = #{x2}."
elsif d == 0
  x1 = (- b + Math.sqrt(d)) / (2 * a)
	puts "Дискриминант = #{d}, x1 = x2 = #{x1}."
else
  puts "Дискриминант меньше 0, корней нет."
end
