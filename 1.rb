#Yukhin programma "idealnii ves"
print "Vvedite vashe imya: "
name = gets.chomp
name.capitalize!
print "Vvedite vash rost: "
high =  gets.chomp.to_i
high1 = high - 110
if high1 <= 0
	print "#{name}, vash ves uje optimalnii."
else
	print "#{name}, vash idealnii ves #{high1}."
end