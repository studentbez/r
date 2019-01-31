# программа "Числа фибоначчи"
fibo = [0, 1]
i = 1
while fibo[i] < 100 do
  i += 1
  fibo[i] = fibo[i-1] + fibo[i-2]
end
fibo.delete_if{|chislo| chislo > 100}
print fibo
