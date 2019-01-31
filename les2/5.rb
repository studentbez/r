#запрашиваем у пользователя  число месяц год. найти порядковый номер даты, начиная отсчет с начала года. учесть високосные года. 
day = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]
print "Введите день: "
date = gets.chomp.to_i
print "месяц: "
month = gets.chomp.to_i
print "год: "
year = gets.chomp.to_i

#в версии выше 2.4 данный цикл не нужен
sum = 0
for i in 0...day.take(month).length do
  sum += day[i]
end 

leap = (year%4 && year%100 && year%400 == 0)
if leap && (month >= 3)
  print "Порядковый номер #{date}/#{month}/#{year}: ", serial_number = date + sum + 1
  #print serial_number = date + day.take(month).sum + 1 /для версии выше 2.4
else
  print serial_number = date + sum
  #print serial_number = date + day.take(month).sum /для версии выше 2.4
end
