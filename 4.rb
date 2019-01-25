#Yukhinni "kvadratnoe uravnenie"
require 'mathn'
puts "Vvedite koefficienti uravneniya ax^2+bx+c=0: "
print "a= "
a = gets.chomp.to_f
print "b= "
b = gets.chomp.to_f
print "c= "
c = gets.chomp.to_f
d = b*b-4*a*c
x1 = (-b + Math.sqrt(d))/(2*a)
x2 = (-b - Math.sqrt(d))/(2*a)
if d > 0 
	print "Disckriminant = #{d}, x1 = #{x1}, x2 = #{x2}"
elsif d == 0
	print "Disckriminant = #{d}, x1 = x2 = #{x1}"
else
	print "Disckriminant menshe 0, kornei net"
end