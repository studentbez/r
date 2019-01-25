#Yukhinni "pryamougolnii treugolnik"
puts "Vvedite 3 storoni treugolnika:"
a = []
for i in (1..3)
	print "#{i} storona = "
	a << gets.chomp.to_f
end

if (a[0]**2 == a[1]**2 + a[2]**2)||(a[1]**2 == a[0]**2 + a[2]**2)||(a[2]**2 == a[1]**2 + a[0]**2)
	print "treugolnik pryamougolnii"
elsif (a[0]==a[1])&&(a[0]==a[2])
	print "treugolnik ravnobedrennii i ravnostoronnii"
elsif (a[0]**2 == a[1]**2 + a[2]**2)||(a[1]**2 == a[0]**2 + a[2]**2)||(a[2]**2 == a[1]**2 + a[0]**2) && ((a[0]==a[1])||(a[1]==a[2])||(a[0]==a[2]))
	print "treugolnik pryamougolnii i ravnobedrennii"
else
	print "treugolnik ne pryamougolnii, ne ravnobedrennii, ne ravnostoronnii"
end