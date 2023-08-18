# Code Fixes 1

# Opdracht:
Deze opdrachten bestaan uit een 16-tal coding challenges die vragen om de scripten werkend te maken.
Deze worden in 2 delen opgedeeld waarbij de eerste 8 in dit bestand staan.
# Uitwerking:

## Opdracht 1

De opdracht vraagt:
``` 
'''
The output should be:
hello Casper
hello Floris
hello Esther
'''
foo = 'hello'
ls = ['Casper', 'Floris', 'Esther']
for name in ls:
	print(loo,name)
```

Dit is een heel simpele typefout: ```print(loo, name)``` moet zijn ```print(foo, name)```.

## Opdracht 2:

```
'''
The output should be:
100
'''
foo = 20
bar = '80'
print(foo + bar)
```
Dit is een fout in het gebruik van de aanhalingsteken in de ```bar = '80'``` variabele; die aanhalingsteken moeten niet gebruikt worden.

### Opdracht 3:

```'''
The output should be:
30
'''
foo = 20
for i in range(10):
	foo -= 1

print(foo)

```
Hierbij moet de ```foo -= 1``` statement ```foor += 1``` zijn. ```-=``` trekt 1 af van het geheel waar ```+=``` er 1 bij op telt.

### Opdracht 4:
```
'''
The output should be:
there are 0 kids on the street
there are 1 kids on the street
there are 2 kids on the street
there are 3 kids on the street
there are 4 kids on the street
'''
foo = 0
while foo <= 5:
	print('there are', foo, 'kids on the street')
	foo += 1
```

Hierbij moet ```while foo <= 5:``` of ```while foo <= 4:``` of ```while foo < 5:``` zijn. ```<=``` zegt dat de True statement geldig is zolang ```foo``` minder of gelijk is aan 5.

### Opdracht 5:
```'''
The output should be:
Star Wars
'''
ls = ['Lord of the rings', 'Star Trek', 'Iron Man', 'Star Wars']
print(ls[4])

```

In het geval van het gebruik van een list index moet er rekening worden gehouden met "zero indexing"; hierbij heeft het eerste item de index ```[0]``` en de 4e item zoals "Star Wars" in deze, de index ```[4]``` of index ```[-1]``` gezien het hier om de laatste item in de list gaat.


## Opdracht 6:

```'''
The output should be:
80
'''
foo = 80
if foo < 30:
	print(foo)
else:
	print('big number wow')
elif foo < 100:
	print(foo)
```

Het probleem hier is dat de ```else``` en ```elif``` statement van de if-statement verkeerd om staan.
De juist manier is:

```foo = 80
if foo < 30:
	print(foo)
elif foo < 100:
	print(foo)
else:
	print('big number wow')
```

### Opdracht 7:
```
'''
The output should be:
['Dog', 'Cat', 'Fly']
'''
ln = ['Dog', 'Cat', 'Elephant', 'Fly', 'Horse']
short_names = []

for animal in ln:
	if len(animal) == 3:
		short_names.append(animal)
	short_names = []

print(short_names)
```

In dit script wordt er eerst een lege lijst gemaakt met ```short_list[]```, daarna wordt deze gevuld met de items met een tekenlengte van 3, en daarna wordt deze weer opnieuw aangemaakt door de 2e ```short_list[]```; dit laatste statement moet verwijderd worden:

```
'''
The output should be:
['Dog', 'Cat', 'Fly']
'''
ln = ['Dog', 'Cat', 'Elephant', 'Fly', 'Horse']
short_names = []

for animal in ln:
	if len(animal) == 3:
		short_names.append(animal)

print(short_names)
```

### Opdracht 8:
```'''
The output should be:
20
'''
foo = 10
bar = 2
print(foo**bar)
```

Deze is ook weer redelijk simpel: de print()-statement heeft een kleine fout; deze moet ```foo*bar``` zijn. Met 2 * wordt er een machtsverheffing aangegeven, waar dit een multiplicatie moet zijn.



