# Python 6
# Onderwerp:
Packages en libraries

# Keyterms:
- Functions
- Packages
- Libraries

# Gebruikte bronnen:
De lessen aangeboden op:
     https://www.codecademy.com/learn/learn-python-3  
De cursus "Python Crash Course" op Cousera welke is aangeboden door Google: 
    https://www.coursera.org/professional-certificates/google-it-automation
De informatie op https://www.w3schools.com/ 

## Ervaren Problemen:
Geen.

# Opdrachten:
## Opdracht 6:
Deze opdracht bestaat uit 3 exercises:
### Exercise 1:
- Import the random package.
- Print 5 random integers with a value between 0 and 100.

### Exercise 2:
- Write a custom function myfunction() that prints “Hello, world!” to the terminal. Call myfunction.
- Rewrite your function so that it takes a string as an argument. Then, it should print “Hello, <string>!”.

### Exercise 3:
-Copy the code below into your script.
```
def avg():
	# write your code here

# you are not allowed to edit any code below here
x = 128
y = 255
z = avg(x,y)
print("The average of",x,"and",y,"is",z)
```
- Write the custom function avg() so that it returns the average of the given parameters. You are not allowed to edit any code below the second comment.

## Exercise 1:
### Import the random package:
Dit gaat via het ```random```-keyword met het package of library die er nodig is; in dit geval is dat het **random** package.

### Print 5 random integers with a value between 0 and 100:
Dit heeft 2 functies nodig:
1) De random integers: dit gaat via de ```randint()```-functie van de random package waarbij de *parameters* van de functie bestaan uit 0 als startpunt en 100 als eindpunt.
Dus in deze: ```randint(1,100)```
2) Een for loop met range()-functie; in deze ```for i in range(5):```

Het volledige script is dan:  
![Het script voor een willekeurige set nummers](/00_includes/Python_images/opdracht6_1_1.png)  
*Het script voor een willekeurige set nummers* 

![De output van het script](/00_includes/Python_images/opdracht6_1_1_output.png)  
*De output van het script*


## Exercise 2:
### Write a custom function myfunction() that prints “Hello, world!” to the terminal. Call myfunction.
Functies worden aangemaakt met het ```def```-keyword. Na het keyword wordt de naam van de functie bepaald; deze wordt gebruikt om de functie te callen/gebruiken.   
![het myfunction() function](/00_includes/Python_images/opdracht6_2_1.png)  
*Het myfunction() function*

![De output van myfunction](/00_includes/Python_images/opdracht6_2_1_output.png)    
*De output van myfunction()*


### Rewrite your function so that it takes a string as an argument. Then, it should print “Hello, <string>!”.
Hierbij krijgt myfunction() een *argument* die in de function call wordt opgegeven tussen de (); in deze is dit het ```arg``` argument welke in de function call de string ```"world!"``` meekrijgt:"  
![myfunction(arg)](/00_includes/Python_images/opdracht6_2_2.png)  
*myfunction() met argument* 

![Output van de myfunction(arg) call](/00_includes/Python_images/opdracht6_2_2_output.png)  
*output van de myfunction(arg) call* 

## Exercise 3:
### Copy the code below into your script:
```
def avg():
	# write your code here

# you are not allowed to edit any code below here
x = 128
y = 255
z = avg(x,y)
print("The average of",x,"and",y,"is",z)
```
### Write the custom function avg() so that it returns the average of the given parameters. You are not allowed to edit any code below the second comment.

Hierbij is het nodig om binnen de avg() -function een tweetal argumenten aan te geven. In deze geef ik deze X en Y. Daarnaast is er een *return*-function nodig die de gemiddelde van X en Y berekend: ```return (x + y)/2``` 
Voor de rest blijft de code het zelfde.
![de avg()-function](/00_includes/Python_images/opdracht6_3_1.png)  
*de avg() -function*

![De output van de avg() -function](/00_includes/Python_images/opdracht6_3_1_output.png)  
*de output van de avg() -function*