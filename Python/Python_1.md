# Python opdrachten

# Onderwerp
Dit is de uitwerking van de opdrachten voor Python.
Ik zal een tweede 



## Keyterms:
- Python basics
- Variables
- Data types
- Comments


## Gebruikte bronnen:
De lessen aangeboden op:
     https://www.codecademy.com/learn/learn-python-3  
En de cursus "Python Crash Course" op Cousera welke is aangeboden door Google: 
    https://www.coursera.org/professional-certificates/google-it-automation


## Ervaren problemen:
Niet per se met deze opdrachten, wel met de oefenopdrachten van de gebruikte bronnen. Hierdoor heb ik geleerd om de code goed te lezen en deze, mocht dat nodig zijn, stap voor stap uit te schrijven en bekijken wat elk deel van de code doet. 


# Opdrachten

# Opdracht 1: Setting up:
Dit is heel simpel het installeren van VSCode en de Python interpreter en daarna deze printopdracht ingeven:
~~~
print("Hello world!")
~~~
![Hello World](/00_includes/Python_images/opdracht_1.png)  
*Hello World* 


```
Side note:
Python kent verschillende datatypes. Deze worden in opdracht 3 besproken maar voor deze opdracht is het handig om te begrijpen dat er hier gebruik gemaakt wordt van een *string*; een stuk tekst zoals een woord of een regel.
Om aan te geven dat een stuk tekst een string als datatype heeft wordt deze tussen aanhalingstekens gezet; zowel enkele of dubbele aanhalingstekens kunnen gebruikt worden, echter mogen deze NIET gecombineerd worden.
```
# Opdracht 2: Variables:
Deze opdracht bestaat uit 3 excersizes:

### Exercise 1:
- Create a new script.
- Create two variables x and y. Assign a numerical value to both variables.
- Print the values of x and y.
- Create a third variable named z. The value of z should be the sum of x and y.
- Print the value of z.

### Excersize 2:
- Create a new script.  
- Create a variable name. The value of name should be your name.  
- Print the text ```Hello, <your name here>!``` Use name in the print statement.


### Excersize 3: 
- Create a new script.  
- Create a variable and assign a value to it.  
- Print the text ```Value 1: <value 1 here>```.  
- Change the value of that same variable.  
- Print the text ```Value 2: <value 2 here>```.  
- Change the value of that same variable.  
- Print the text ```Value 3: <value 3 here>```.  


## Uitwerking:
## Exercise 1:
#### **Create a new script.**   
Dit gaat simpel via **ctrl+n** of *file -> new file*   

### **Create two variables x and y. Assign a numerical value to both variables.**  

Dit gaat via de syntax: ```variable = value```
**Print the values of x and y.**
Dit gaat via de ```print()``` functie:
![Variables x and y plus print statement](/00_includes/Python_images/opdracht2_1_1.png)  
*x en y variables en print()-statement*   

### **Create a third variable named z. The value of z should be the sum of x and y.**
Dit gaat via de syntax ```var1 = var2 + var3```

De meest gebruikte mathmetical operators zijn:
```
Operator | handeling
+        | Optellen
-        | Aftrekken
*        | Vermenigvuldigen
/        | Delen
**       | Machtsverheffen
%        | Modulus -> bepaald het restgetal van een deling  
//       | Floor division -> bepaald het hele quotiënt van een deling

```

### **Print the value of z.**

Dit is ook weer een ```print()``` opdracht:  
![z = x + y](/00_includes/Python_images/opdracht2_1_2.png)  
*z = x + y* 
![Output van de z = x + y opdracht](/00_includes/Python_images/opdracht2_1_3_output.png)
*Output van z = x + y* 

## Exercise 2:
### **Create a new script.**  
Dit gaat via ctrl+n of *file -> new file*  

### **Create a variable name. The value of name should be your name.**   
Dit gaat via de syntax ```variable = value``` waarbij de value een string moet zijn, dus tussen aanhalingstekens moet worden gezet:  

![name variabele als string](/00_includes/Python_images/opdracht2_2_1.png)  
*name variabele als string* 

### **Print the text ```Hello, <your name here>!``` Use name in the print statement.**  

De ```print()``` functie kan naast strings ook de waarde van variabelen printen. Hierbij is het via **concatenation** mogelijk om verschillende datatypes me 1 print statement te printen.   
Bij concetanation worden verschillende onderdelen van een ```print()```statement aan elkaar gekoppeld met een + of een , (comma). Dit zal alle onderdelen binnen het statement als 1 zin printen.

Bij deze opdracht is de syntax: ```print("Hello", name)``` en zal de printopdracht ```Hello Jeroen``` printen. Hierbij is "hello" een string en **name** een variable:  
![print("Hello", name)](/00_includes/Python_images/opdracht2_2_2.png)  
*print("hello", name)* 

![Output van de print() statement](/00_includes/Python_images/opdracht2_2_2_output.png)
*Output van de print() opdracht* 

## Exercise 3
### **Create a new script.** 
Dit gaat via ctrl+n of *file -> new file* 

### **Create a variable and assign a value to it.**  
Dit gaat via de syntax ```variable = value``` waarbij ik gekozen heb voor *name = naam*


### **Print the text ```Value 1: <value 1 here>```.** 
Dit gaat via ```print(variable)```:  
![print(name)](/00_includes/Python_images/opdracht2_3_1.png)  
*print(name*)
![Output van print(name)](/00_includes/Python_images/opdracht2_3_1_output.png)  
*Output van print(name)*

### **Change the value of that same variable.** 
Hierbij wordt de naam en value van de variable aangepast.

### **Print the text ```Value 2: <value 2 here>```.**
Dit doe ik in 1 keer samen met value 3

### **Change the value of that same variable.**
Ook hier wordt de naam en value van de variabele aangepast. 

### **Print the text ```Value 3: <value 3 here>```.**
Dit gaat weer via een ```print()``` opdracht. Deze heb ik samen met value2 gedaan:  

![Value2 en 3](/00_includes/Python_images/opdracht2_3_2.png)  
*value 2 en 3*

![Output van de print() opdrachten](/00_includes/Python_images/opdracht2_3_2_output.png)
*output van value 2 en 3*

# Opdracht 3: Data types and comments:
## Exercise 1:

- Create a new script.
- Copy the code below into your script.  
a = 'int'  
b = 7  
c = False  
d = "18.5"  
- Determine the data types of all four variables (a, b, c, d) using a built in function.  
- Make a new variable x and give it the value b + d. Print the value of x. This will raise an error. Fix it so that print(x) prints a float.  
- Write a comment above every line of code that tells the reader what is going on in your script.  


## Exercise 2:
- Create a new script.
- Use the input() function to get input from the user. Store that input in a variable.
- Find out what data type the output of input() is. See if it is different for different kinds of input (numbers, words, etc.).


## Exercise 1:
### **Create a new script.** 
Dit gaat via ctrl+n of *file -> new file* 

### **Copy the code below into your script:**   
a = 'int'  
b = 7  
c = False  
d = "18.5"  
Dit is letterlijk overnemen van de opdracht via een copy&paste.

### **Determine the data types of all four variables (a, b, c, d) using a built in function.**  
De built in function die nodig is om de data type van een variable te bepalen en te printen is ```type``` en de syntax is: ```print(type(variable))```.  
De data types die het meest worden gebruikt zijn:
- String: een stuk tekst. Dit wordt als <class 'str'> aangegeven.
- Boolean: True or False. Dit wordt als <class 'boo'> aangegeven.
- Integer: een heel getal. Dit wordt als <class 'int'> aangegeven.
- Float: een decimaal getal. Dit wordt als <class 'float'> aangegeven.
- List: een lijst. Dit wordt als <class 'list'> aangegeven.

![De data types van de variabelen](/00_includes/Python_images/opdracht3_1_1.png)  
*De data type van de variabelen*

![De output van de type opdracht](/00_includes/Python_images/opdracht3_1_1_output.png)  
*De output van de type opdracht*

### **Make a new variable x and give it the value b + d. Print the value of x. This will raise an error. Fix it so that print(x) prints a float.**

Dit geeft eerst de foutmelding ```TypeError: unsupported operand type(s) for +: 'int' and 'str'```, dit zegt dat een integer en een string niet bij elkaar opgeteld kunnen worden.

![x = b +d](/00_includes/Python_images/opdracht3_1_2.png)    
*x = b + d*   

![x = b + d foutmelding](/00_includes/Python_images/opdracht3_1_2_output.png)     
*x = b + d foutmelding* 

Om dit probleem op te lossen en van de output een *float* te maken is het nodig om de ```float()``` functie te gebruiken waarbij de syntax ```float(var)``` is:  

![x = float(b) + float(d)](/00_includes/Python_images/opdracht3_1_3.png)  
*x = float(b) + float(d)* 
 
 ![Output van x = float(b) + float(d)](/00_includes/Python_images/opdracht3_1_3_output.png)  
 *output van x = float(b) + float(d)*


### **Write a comment above every line of code that tells the reader what is going on in your script.** 
 Comments worden geschreven door voor een comment een # te plaatsen.

![Het schrijven van comments](/00_includes/Python_images/opdracht3_1_4.png)

## Exercise 2

### **Create a new script.**
Dit gaat via ctrl+n of *file -> new file* 

### **Use the input() function to get input from the user. Store that input in a variable.**
Hierbij wordt de value van een variabele bepaald aan de hand van de ```input()``` functie waarbij de input een aan de gebruiker gevraagde input is. Dit gaat bijvoorbeeld via een vraag, en gaat met de volgende syntax:
```
value1 = input("What is value1?")
``` 

In deze vraagt de input() functie om iemands favoriete getal van 0 tot 9:
![De input() functie](/00_includes/Python_images/opdracht3_2_1.png)  
*input() functie*


![De output van de input() functie](/00_includes/Python_images/opdracht3_2_1_output.png)
*print of input()*



### **Find out what data type the output of input() is. See if it is different for different kinds of input (numbers, words, etc.).** 
Dit gaat via de type() functie.
In deze wordt er 3 maal om een input gevraagd: 1 voor een getal, 1 voor een naam en 1 voor een boolean (True of false):  
![Input en type functies](/00_includes/Python_images/opdracht3_2_2.png)  
*Input en type functies*  

Als er dan wordt bekeken wat de type van elke output is blijkt dat alle variabelen een String-type zijn. 

![De type van de variabelen met een input functie](/00_includes/Python_images/opdracht3_2_2_output.png)  
*De data type van de variabelen met een input functie* 

Om een variabele toch naar een andere data type om te zetten zijn de *constructor functies* nodig. Deze bestaan uit de syntax ```constructor_function(variabele)``` waarbij de volgende constructor functies mogelijk zijn:
```
constructor functie | data type
str()               -   String
int()               -   Integer
Float()             -   Float
List()              -   List
Tuple()             -   Tuple
```
Deze werken allen exact hetzelfde via de syntax```constructor_function(variable)```.