# программа "Числа фибоначчи"
fibo = [0, 1]
while (fibo[-1] + fibo[-2]) < 100 do 
  fibo.push(fibo[-1] + fibo[-2])
end
print fibo
