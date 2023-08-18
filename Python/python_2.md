# Python 2

## Onderwerp:
Opdrachten 4 en 5

## Key-terms:
- if, elif, else -statements
- loops
- range() -function
- for loop
- while loop
- conditional operators

## Gebruikte bronnen:
De lessen aangeboden op:
     https://www.codecademy.com/learn/learn-python-3  
En de cursus "Python Crash Course" op Cousera welke is aangeboden door Google: 
    https://www.coursera.org/professional-certificates/google-it-automation
## Ervaren Problemen:
Geen.

# Opdrachten:
# Opdracht PRG-4: Loops
Deze opdracht bestaat uit 3 exercises:

### **Exercise 1:**
- Create a variable x and give it the value 0.
- Use a while loop to print the value of x in every iteration of the loop. After printing, the value of x should increase by 1. The loop should run as long as x is smaller than or equal to 10.

### **exercise 2:**
- Copy the code below into your script:
```for i in range(10):
	# do something here
```
- Print the value of i in the for loop. You did not manually assign a value to i. Figure out how its value is determined.
- Add a variable x with value 5 at the top of your script.
- Using the for loop, print the value of x multiplied by the value of i, for up to 50 iterations.


### **exercise 3:** 
- Copy the array below into your script.
arr = ["Coen", "Casper", "Joshua", "Abdessamad", "Saskia"]
- Use a for loop to loop over the array. Print every name individually.

# Uitwerking:
## **Exercise 1:**
### Create a variable x and give it the value 0.
Dit gaat heel simple met ```x = 0```


### Use a while loop to print the value of x in every iteration of the loop. After printing, the value of x should increase by 1. The loop should run as long as x is smaller than or equal to 10.
Dit gaat via een while loop en heeft de volgende uitwerking:  
![While loop code](/00_includes/Python_images/opdracht4_1_1.png)  
*While loop code*  

![Output van de while loop](/00_includes/Python_images/opdracht4_1_1_uitwerking.png)  
*Output van de while loop*  


## **exercise 2:**
### Copy the code below into your script:
```
for i in range(10):
	# do something here
```
Zeer simpele copy&paste.

### Print the value of i in the for loop. You did not manually assign a value to i. Figure out how its value is determined.
De range()-function zal de cijfers 0 - 9 printen. Dit omdat i een lege variabele is en bij elke iteratie van de range()-functie een value krijgen van 0 - 9. 
Hierbij is het belangrijk om te snappen dat Python "0-indexing" gebruikt; elke indexering start daarbij met 0 ipv 1.

### Add a variable x with value 5 at the top of your script.
Dit is heel simpel: ```x = 5```

### Using the for loop, print the value of x multiplied by the value of i, for up to 50 iterations.
Dit is iets complexer maar nog altijd zeer simpel. Hierbij moet de range()-functie ```range(50)``` worden, en de print()-statement ```print(x * i)```. Dit zal alle vermenigvuldigingen van 5 tussen de 0 en 249 printen.


## **exercise 3:** 
### Copy the array below into your script.
arr = ["Coen", "Casper", "Joshua", "Abdessamad", "Saskia"]
Dit is een simpele copy&paste.

### Use a for loop to loop over the array. Print every name individually.
Dit gaat weer met een print() statement waarbij de for loop itereert over de namen in de arr-list. De namen krijgen de tijdelijke variabele *name* mee, waardoor de for loop de syntax ```for name in arr:``` krijgt en deze de print(name) opdracht krijgt:

![for name in arr](/00_includes/Python_images/opdracht4_3_1.png)  
*for name in arr* 

![Output van de for loop](/00_includes/Python_images/opdracht4_3_1_output.png)
*output van de for loop*

# Opdracht PRG-5: Conditionals
Deze opdracht kent 2 exercises:
- Use the input() function to ask the user of your script for their name. If the name they input is your name, print a personalized welcome message. If not, print a different personalized message.

- Ask the user of your script for a number. Give them a response based on whether the number is higher than, lower than, or equal to 100.


## Exercise 1:
### Use the input() function to ask the user of your script for their name. If the name they input is your name, print a personalized welcome message. If not, print a different personalized message.

Voor deze opdracht is het nodig om een conditional loop te maken. Binnen een conditional loop wordt er gebruik gemaakt van een if/else -statement eventueel aangevuld met een elif -statement en waar binnen met de logical *and*, *or* en *not* gewerkt kan worden.

De opdracht zelf vraagt om een een loop waarbij de input()-functie als trigger voor de conditional geldt.
Om de input te vergelijken met de waarde van een variabele is het nodig om een *comparison operator* te gebruiken.
De operators die er gebruikt kunnen worden zijn:
```
Operator | name
==       | gelijk aan
!=       | NIET gelijk aan
>        | Groter dan
<        | Kleiner dan
>=       | Groter dan of gelijk aan
<=       | Kleiner dan of gelijk aan.

```

In deze wordt de *==* operator gebruikt bij de if-statement en wordt er een print()-statement als actie van de conditional gebruikt.

![If statement](/00_includes/Python_images/opdracht5_1_1.png)  
*het if statement*

![De output van de conditional loop](/00_includes/Python_images/opdracht5_1_1_output.png)  
*De output van de conditional loop*


## Exercise 2:
### Ask the user of your script for a number. Give them a response based on whether the number is higher than, lower than, or equal to 100.
Ook hier wordt een if statement gebruikt, maar dan in combinatie van zowel een *else* als een *elif* statement. Een *elif* statement zal als alternatief worden vergeleken als het *if* statement niet getriggerd wordt. Voor de rest werkt deze exact hetzelfde als een *if* statement.

![if statement met een elif statement](/00_includes/Python_images/opdracht5_2_1.png)  
*if statement met een elif statement* 

![Output van het if statement](/00_includes/Python_images/opdracht5_2_1_output.png)
*output van het if statement*

### Make the game repeat until the user inputs 100
Dit is wat moeilijker. Hierbij is het nodig om de gehele code aan te passen. Hierbij wordt er niet alleen gebruik gemaakt van een for loop maar ook een while loop en een exit() conditional. Deze while loop loopt totdat het goede getal geraden wordt. Om de loop te stoppen kan het *exit()* keyword worden gebruikt.

![While loop met if loop](/00_includes/Python_images/opdracht5_2_2.png)  
*while loop met if loop*  
![output van de while loop](/00_includes/Python_images/opdracht5_2_2_output.png)  
*output van de while loop*