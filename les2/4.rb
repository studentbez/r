#заполнить хэш глассная-порядковый номер
letter = ('a'..'z').to_a
volwes = ['a', 'i', 'o', 'e', 'y', 'u']
out = {}
volwes.each { |key, value| out[key] = letter.index(key) + 1 }
print out
