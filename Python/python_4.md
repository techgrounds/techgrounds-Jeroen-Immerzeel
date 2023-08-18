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
Hulp van chatgpt
De informatie op https://docs.python.org/3/library/csv.html en andere pagina's van de python.org website.


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

Dit was voor mij veruit de moeilijkste opdracht; dit bleek ook zo te zijn voor bijna alle medestudenten.
Ik kon zelf in eerste instantie geen werkend script maken. Na het gebruik van chatGPT en python.org om het een en ander te bouwen kwam ik uit op het volgende:

![Het script](/00_includes/Python_images/opdracht8_2_2.png)
*Mijn eerste versie*

Dit gaf als output na het converteren binnen Excel:  
![Excel bestand met de csv data geconverteerd naar rijen en columns](/00_includes/Python_images/opdracht8_excel.png)


Dit was op zich voldoende voor de opdracht, maar ik snapte nog steeds niet wat het script nu echt deed.
Toen ik elke stap apart bekeek kwam ik uit op de volgende uitleg per stap:
![Het script met voor elke stap een comment met uitleg](/00_includes/Python_images/opdracht8_2_1.png)