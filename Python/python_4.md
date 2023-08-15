# Python opdracht PRO-7 en PRO-8
# Onderwerp: Lists en Key- value pairs

# keyterms:
- Lists
- Key-value pairs

# Gebruikte bronnen:
De lessen aangeboden op:
     https://www.codecademy.com/learn/learn-python-3  
De cursus "Python Crash Course" op Cousera welke is aangeboden door Google: 
    https://www.coursera.org/professional-certificates/google-it-automation
De informatie op https://www.w3schools.com/ 
chatgpt

# Ervaren problemen:
Voor opdracht8, exercise 2 kon ik eigenlijk nergens de informatie vinden die dit duidelijk uitlegde. IK he hiervoor ChatGPT gebruikt.

# Uitwerking:
# Opdracht 7
## Exercise 1:
### Create a variable that contains a list of five names.
Een list wordt gemaakt door een variabele aan te maken welke uit een lijst met items bestaat waarbij de items tussen blokhaakjes [] en aanhalingstekens staan; bijvoorbeeld: ```my_list = ["a", "b", "c", "d"]```

In deze moet de list uit 5 names bestaan, dus: 

### Loop over the list using a for loop. Print every individual name in the list on a new line.
Dit gaat simpel met ```for name in names:``` en ```print(name)```:

![Het script](/00_includes/Python_images/opdracht7_1_1.png)   

Wat als output geeft:

![De output van het script](/00_includes/Python_images/opdracht7_1_1_output.png)  

## Exercise 2:
### Create a list of five integers.
Dit is simpel ```my_list = [1, 2, 3, 4, 5]```

### Use a for loop to do the following for every item in the list:
- Print the value of that item added to the value of the next item in the list. 
- If it is the last item, add it to the value of the first item instead (since there is no next item).
Dit betekent het optellen van item 1 en 2, 2 en 3, 3 en 4, 4 en 5 en 5 en 1.

Het script wordt dan:  

![Het script](/00_includes/Python_images/opdracht7_2_1.png)   

En de output:   

![De output](/00_includes/Python_images/opdracht7_2_1_output.png) 


# Opdracht 8:
## Exercise 1
### Create a dictionary with the following keys and values:

![Table van opdracht 8](/00_includes/Python_images/opdracht8_table.png) 

Het maken van een dictionary gaat via deze syntax:
```
new_dict = {
"key": "value",
"key 2": "value 2",

}
```
Voor deze opdracht is de dictionary dan:

![De dictionary](/00_includes/Python_images/opdracht8_1_1.png)

### Loop over the dictionary and print every key-value pair in the terminal.
Dit kan best simpel met een for loop en de ```.items()``` method:

![Het script](/00_includes/Python_images/opdracht8_1_2.png)  

En dan wordt de output:

![De output van de for loop van een dictionary](/00_includes/Python_images/opdracht8_1_2_output.png)

# Exercise 2:
### Use user input to ask for their information (first name, last name, job title, company). Store the information in a dictionary.

Hiervoor zijn de volgende stappen nodig:
1) het aanmaken van een lege dictionary met ```dict = {}```
2) Het maken van een for loop waarbij de user gevraagd wordt voor de nodige informatie

![De dictionary met lege velden](/00_includes/Python_images/opdracht8_2_0.png)

*De dictionary met lege velden*


![De output van dit script](/00_includes/Python_images/opdracht8_2_0_output.png)

*De output van het script*

### Write the information to a csv file (comma-separated values). The data should not be overwritten when you run the script multiple times.

Dit is zeer complex.
Hierbij is het nodig om de csv package en het os package te importeren.
Daarna moet er een file path worden bepaald.
En als laatste moet een aantal regels worden toegevoegd: een writer, een header en de values zelf. En daarnaast nog een hele hoop andere dingen.

Hierbij wordt het script bijvoorbeeld:

![Het script](/00_includes/Python_images/opdracht8_2_1.png)

Een ander voorbeeld is:
![Alternatief](/00_includes/Python_images/opdracht8_2_2.png) 

Dit is geenzins een simpel iets, en ik snap dit geheel niet voldoende nog. 
Wat is wel snap is:  
- ```with open``` opent een file  
- ```csv.writer``` schrijft een csv file  
- ```de 'w' en 'a' ``` staan voor "write" en "append"  