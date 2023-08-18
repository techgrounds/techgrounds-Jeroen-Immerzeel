# Code fixes 2

# Opdracht:
Deze opdrachten bestaan uit een 16-tal coding challenges die vragen om de scripten werkend te maken.
Deze worden in 2 delen opgedeeld waarbij de laatste 8 in dit bestand staan.

### Opdracht 9:
```
'''
The output should be:
0
1
2
3
4
8
9
'''
for i in range(10):
	if i < 5:
		print(i)
	elif i < 8:
		break
	else:
		print(i)
```

Dit kan opgelost worden door dit simplerer te schrijve met:
```
for i in range(10):
	if i < 5 or i >= 8:
		print(i)
    
```

### Opdracht 10:

```'''
The output should be:
the number is 20
'''
print('the number is' + 20)
```

Hierbij is het probleem dat ```20``` een integer is en geen string. Daarom is het nodig om van deze via een ```str()``` constructor function een string data type te maken:

```
'''
The output should be:
the number is 20
'''
print('the number is' + str(20))
```
### Opdracht 11:
```
'''
The output should be:
IT LIVES!
'''
dev monster():
	print('IT LIVES!')

monster()
```
Dit is een zeer simpel typefoutje; ```dev``` moet ```def``` zijn.

### Opdracht 12:
```
'''
The output should be:
4
16129
'''
def square(x):
	return x**2

nr = square(2)
print(nr)

big = square(foo)
print(big)

foo = 127
```

Dit is een kwestie van een variabele die niet op de goed plaats in de code staat. ```foo = 127``` staat onderaan maar moet juist bovenaan staan; nu kan de ```big = square(foo)``` function call geen gebruik maken van de variabele ```foo``` waar als ```foo``` bovenaan staat dit wel kan.
De oplossing is dan ook:

```
'''
The output should be:
4
16129
'''
foo = 127
def square(x):
	return x**2

nr = square(2)
print(nr)

big = square(foo)
print(big)
```

### Opdracht 13:

```
'''
The output should be:
Your random number is: <insert random number here>
'''
import random

random.randint(1,100)
print("Your random number is:")
```
In deze wordt de ```random.randint(1, 100)``` functie wel opgeroepen maar niet gebruikt om de waarde van een variabele te bepalen waar dit wel nodig is.
De oplossing kan dan zijn:

```
'''
The output should be:
Your random number is: <insert random number here>
'''
import random

number = random.randint(1,100)
print("Your random number is:", number)
```


### Opdracht 14:

``` '''
The output should be:
True
'''
def rtn(x):
	return(x)

foo = rtn(3)

if foo > rtn(4):
	print(True)
else:
	print(False)
````

Hierbij wordt gekeken of ```rtn()``` groter is dan 4. Gezien dit 3 is, is de boolean False. 
Om deze True te maken is het mogelijk om:
- de regel ```foo = rtn(3)``` te veranderen naar ```foo rtn(4)```
- de vergelijking ```if foo > rtn(4)``` te veranderen naar ```if foo < rtn(4)```
- de print statements om te draaien waarbij True false wordt en vise versa.

### Opdracht 15:
```'''
The output should be:
a5|||5|||5|||a5|||5|||5|||a5|||5|||5|||
'''
foo = ''
for i in range(3):
	foo += 'a'
	for j in range(3):
		foo += '5'
	for k in range(3):
		foo += '|'

print(foo)
```

Dit is een wat complexere opdracht.
Op deze manier zal er 1 maal de ouput ```aaa5|||5|||5|||``` worden getoond. Er moeten dus 2 aanpassingen worden gedaan:
1) "a" moet maar 1 keer getoond worden; dit kan door de ```for i in range(3)``` aan te passen naar ```for i in range(1)```.
2) De gehele string moet daarna 3 keer getoon worden; dit gaat door de print statement aan te passen naar ```print(foo*3)```.
Dit zal het volgende script worden:

```
'''
The output should be:
a5|||5|||5||| a5|||5|||5||| a5|||5|||5|||
'''
foo = ''
for i in range(1):
	foo += 'a'
for j in range(3):
	foo += '5'
	for k in range(3):
		foo += '|'

print(foo*3)
```

### Opdracht 16:

```
'''
The output should be:

'''
import random

# generate random int
goal = random.randint(1,100)

win = True
tries = 0

while win == False and tries < 7:
	try:
		# ask for input
		inpt = int(input("Please input a number between 1 and 100: "))
		# count attempt as a try
		tries += 1

		# check for match
		if inpt == goal:
			win = True
			print("Congrats, you guessed the number!")
			print("It took you", tries, "tries")
		# give hints
		elif inpt < goal:
			print("The number should be higher")
		else:
			print("The number should be lower")

	except:
		print("Please type an integer")

# 
if win == False:
	print("Game over! You took more than seven tries")

```

Deze heeft tot een leuke discussie geleid. 
De een leest in de opdracht dat er iets niet werkt, en wij moeten vinden wat, de ander neemt de opdracht letterlijk en zorgt voor een blanco output; zo ik ook.
Dit doe ik door de ```win = True``` evaluation te veranderen in ```win = False```; dit zal het spel niet starten en een blanco output geven.