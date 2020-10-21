file = open('Demina.ged', 'r', encoding="utf8")
tree = open('Demina.pl', 'w+', encoding="utf8")

id = []
name = []
gender = []
n = 0

for line in file:

	if line[0] == '0' and line[2] == '@' and line[12] == 'I':
		id.insert(n, '')
		i = 0
		while line[i + 4] != '@':
			id[n] += line[i + 4]
			i += 1
#		print (id[n])

	if line[0] == '2' and line[2] == 'G':
		name.insert(n, '')
		i = 0
		while line[i + 7] != '\n':
			name[n] += line[i + 7]
			i += 1
		a = 0
		while a != n:
			if name[n] == name[a]: name[n] += 'I'
			a += 1
#		print (name[n])
#		print (n)

	if line[0] == '1' and line[2] == 'S' and line[4] == 'X': 
		gender.insert(n, line[6])
#		print (gender[n])
		n += 1

	if line[0] == '1' and line[2] == 'H' and line[3] == 'U':
		string = ''
		i = 0
		while line[i + 9] != '@':
			string += line[i + 9]
			i += 1
		a = 0
#		print (string)	
		while a != n:
			if string == id[a]: husb = a
			a += 1
#		print (name[husb])	

	if line[0] == '1' and line[2] == 'W' and line[3] == 'I':
		string = ''
		i = 0
		while line[i + 9] != '@':
			string += line[i + 9]
			i += 1
		a = 0
		while a != n:
			if string == id[a]: wife = a
			a += 1
#		print (name[wife])	

	if line[0] == '1' and line[2] == 'C' and line[4] == 'I':
		string = ''
		i = 0
		while line[i + 9] != '@':
			string += line[i + 9]
			i += 1
		a = 0
		while a != n:
			if string == id[a]: child = a
			a += 1
#		print (name[child])
		tree.write("child('" + name[child] + "', '" + name[wife] + "').\n")
		tree.write("child('" + name[child] + "', '" + name[husb] + "').\n")
#		print ('child(' + name[child] + ', ' + name[wife] + ').')
#		print ('child(' + name[child] + ', ' + name[husb] + ').')


a = 0	
while a != n:
	if gender[a] == 'F': tree.write("female('" + name[a] + "').\n")
	if gender[a] == 'M': tree.write("male('" + name[a] + "').\n")
#	if gender[a] == 'F': print ('female(' + name[a] + ').')
#	if gender[a] == 'M': print ('male(' + name[a] + ').')
	a += 1

tree.write('\n\ndever(X, Y) :-\n female(X),\n male(Y),\n child(Z, X),\n child(Z, M),\n child(M, P),\n child(Y, P).\n')

tree.close()
