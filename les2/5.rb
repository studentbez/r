#запрашиваем у пользователя  число месяц год. найти порядковый номер даты, начиная отсчет с начала года. учесть високосные года. 
day = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]
print "Введите день: "
date = gets.chomp.to_i
print "месяц: "
month = gets.chomp.to_i
print "год: "
year = gets.chomp.to_i

leap = (year % 4 && year % 100 && year % 400 == 0)
if leap && (month >= 3)
  print date + day.take(month).sum + 1
else
  print date + day.take(month).sum
end
