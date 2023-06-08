# Linux opdrachten 5 tot en met 8
*Dit zijn de laatste 4 opdrachten voor Linux samengevoegd*

## Key-terms:
- Permissions
- File beheer
- Bash scripting
- PATH enviroment variable
- shebang
- systemctl
- apt suite

# Opdracht LNX-05: File Permissions

Deze opdracht gaat over het beheren van de rechten binnen Linux.

Binnen deze opdracht worden de volgende 6 deelopdrachten gevraagd:

- Create a text file.
- Make a long listing to view the file’s permissions. Who is the file’s owner and group? What kind of permissions does the file have?
- Make the file executable by adding the execute permission (x).
- Remove the read and write permissions (rw) from the file for the group and everyone else, but not for the owner. Can you still read it?
- Change the owner of the file to a different user. If everything went well, you shouldn’t be able to read the file unless you assume root privileges with ‘sudo’.
- Change the group ownership of the file to a different group.

### *"1: Create a text file."*
Deze opdracht is simpel en kan op meerdere manieren:
- echo "tekst" > file.txt
- touch > file.txt
- met een tekst editor als VIM, Nano of Emac 

Wat ook leuk is om te weten is dat in Linux elke file een tekstbestand is, en dat een extensie niet nodig is; deze zijn er puur voor de gebruiker om snel te zien waarvoor een bestand gebruikt wordt. 

![Het aanmaken van een tekstfile](/00_includes/permissions_1.png)  
*aanmaken van een tekstfile*

### *2: Make a long listing to view the file’s permissions. Who is the file’s owner and group? What kind of permissions does the file have?*

Deze deelopdracht kent een aantal onderdelen:
- Het maken van een long-listing.
- Het bepalen van de owner en group van de file aan de hand van de output van de long-listing.
- Het bepalen van de permissions.

**Het maken van een long listing:**  

Een *long listing* maken gaat via het **ls -l** commando.

![Long listing van de aangemaakte permissions.txt](/00_includes/permissions_ls.png)  
*De output van ls -l*

**Who is the file’s owner and group?**  

De file's owner en group worden in de long-listing getoond: er staan na de effectieve permissions en het aantal links, 2 namen in de listing: de eerste is de user en de tweede de group waartoe een file toe behoort.  

De aangemaakte file kent in deze de **owner jeroen_** en de **group jeroen_** als de owner en group.

**What kind of permissions does the file have?**

De permissions op de file zijn: *-rw-rw-r--*.   
Hierbij worden de permissions onderverdeeld in:
- read (r)
- write (w)
- execute (x)  

Omdat de permissies worden gelezen als *file type code* > user > group > others kent deze file de volgende permissions per onderdeel:
- De user: read en write
- De group read en write
- En others read

```
Files en directories kennen elk iets andere definities voor de permissions:
Files:
**Read** geeft permission om de inhoud van de file te lezen.
**write** geeft permission om de inhoud van een file aan te passen.
**execute" geeft de permission tot het uitvoeren van de file als zijne een binary of script.

Directories:
**read** geeft permission om de inhoud in de directory te bekijken.
**write** geeft permission om het aanpassen van de files in de directory.
**execute** geeft permission om de directory als working directory te gebruiken, dit zolang dit ook geldt voor parent directories.
```

## *"3: Make the file executable by adding the execute permission (x)."*

*Ik ga hierbij vanuit dat het gaat om de execute permission voor de user.*

Het aanpassen van de permissions op een file of directory gaat via het **chmod** commando.
Deze kent 2 verschillende manieren om te werken:
- Octal mode waarbij er een value wordt opgegeven, is complexer.
- Symbolic mode waarbij er gewerkt wordt met modelevels en code, is wat simpeler.

**Octal mode**

Octal mode maakt gebruik van 8 verschillende **octal values** om de rechten te definiëren.  
Een overzicht van deze 8 mogelijke values:  
- 0 -> --- -> no permissions
- 1 -> --x -> execute only
- 2 -> -w- -> write only 
- 3 -> -wx -> write and execute
- 4 -> r-- -> read only
- 5 -> r-x -> read and execute
- 6 -> rw- -> read and write
- 7 -> rwx -> read, write and execute

Het is hierbij dus nodig om eerst de octal value te bepalen en deze als argument binnen het chmod commando op te geven.  

Dus om met **octal mode** het permissions.txt -file te voorzien van een excute permission moet deze het octal value van 7 krijgen voor de user terwijl de group en other hun permissions behouden, welke respectivelijk 6 en 3 zijn. 

Hierdoor is het uiteindelijke commando voor de opdracht:  
 **chmod 763 permissions.txt**

![Permissions aanpassen met octal mode](/00_includes/permissions_user_octal.png)  
*octal mode*

**Symbolic mode**

In symbolic mode wordt er gewerkt met een simpele x=y notering waarbij x de user/group/others is, de \-, \+ en \= wat je wilt doen met de rechten, en y de rechten die aangepast moeten worden.  

De user, group en others worden bepaald via u, g en o:
- u is user
- g is group
- o is others

Met + - en = wordt het soort aanpassing gespecificeerd:
- \+ is toevoegen
- \- is verwijderen
- \= bepaald dat alleen deze permissions wordt toegekent.

Met r,w en x worden de rechten gespecificeerd.

Het is hierbij mogelijk om zowel de user/group/others als de permissions te combineren; dus ugo=rwx is gewoon mogelijk.

Hierdoor is het uiteindelijke commando voor de opdracht:  
**chmod u+x permissions.txt**

![permissions aanpassen met chmod u+x](/00_includes/permissions_user_x.png)  
*symbolic mode*

## *"4: Remove the read and write permissions (rw) from the file for the group and everyone else, but not for the owner. Can you still read it?*"

Dit wordt ook weer gedaan met het **chmod** commando.
In deze moet het gehele commando 1 van deze 2 commando's zijn:  
**chmod 600 permissions.txt**  
**chmod go-rwx permissions.txt**

![Permissions verwijderen via octal mode](/00_includes/permissions_remove_octal.png)  
*octal mode*  

<br>

![Permissions verwijderen via symbolic mode](/00_includes/permissions_remove_symbolic.png)  
*symbolic mode*

Na het verwijderen van de rechten voor de group en others kan de user deze nog altijd lezen; de read permission van de user er is immers nog altijd.

![De user heeft nog altijd read permissions](/00_includes/cat_permissions.png)  
*read permission user*

### *"5: Change the owner of the file to a different user. If everything went well, you shouldn’t be able to read the file unless you assume root privileges with ‘sudo’. "*

Dit gaat via het **chown** commando. Deze heeft een zeer simpele syntax:  
**chown [OPTIONS] NEWOWNER FILE(s)**

Dus om de user JBond de eigenaar te laten worden van de permissions.txt file is het commando:  
**chown JBond permissions.txt**

![Chown JBond permissions.txt](/00_includes/change_ownership_user.png)    
*JBond is de nieuwe owner*
<br>

![De user jeroen_ kan de file niet lezen](/00_includes/cat_permission_denied.png)    
*Geen read permissions, dus "permission denied"*
<br>
<br>

### *"6: Change the group ownership of the file to a different group."*

Ook dit is redelijk simpel en gaat via het **chgrp** commando. Deze kent eigenlijk dezelfde syntax als **chown**:  
**chgrp [OPTIONS] NEWGROUP FILENAME(s)**

Dus om de group "admin" de group te laten worden die eigenaar is van permissions.txt is het commando:  
**chgrp admin permissions.txt**

![De group was jeroen_](/00_includes/group_owner_jeroen.png)  
*De group was jeroen_*


![De group na chgrp is admin](/00_includes/group_owner_admin.png)  
*De group is nu admin* 


# Opdracht LNX-06: Bash Scripting.

Deze opdracht gaat over de basis van Bash Scripting.

Binnen deze opdracht worden de volgende n deelopdrachten gevraagd:

**Deel 1:**  
- Create a directory called ‘scripts’. Place all the scripts you make in this directory.
- Add the scripts directory to the PATH variable.
- Create a script that appends a line of text to a text file whenever it is executed.
- Create a script that installs the httpd package, activates httpd, and enables httpd
- Finally, your script should print the status of httpd in the terminal.

**Deel 2:**  
- Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file.


**Problemen die ik ben tegengekomen:**
De naam van de httpd package bleek apache2 te zijn; dat gaf we wel even wat tijd om te realiseren.
Ook een fout maken met het PATH variable gaf mij wat problemen die ik met behulp van mijn boek kon oplossen. Hier bleek het gebruik van full paths de oplossing te zijn. 

## Deel 1:

### *"1: Create a directory called ‘scripts’. Place all the scripts you make in this directory."*

Dit gaat simpel met **mkdir**.
Het volledige commando is:  
**mkdir scripts**

### *"2: Add the scripts directory to the PATH variable."*

Dit is iets complex dan opdracht 1, maar nog altijd redelijk simpel.  

Het PATH bestaat uit de locaties die Bash doorzoekt om commando's te zoeken voor het uitvoeren. Om een map of executable toe te voegen aan het PATH wordt dit basis commando gebruikt:  
**export PATH=...:$PATH**  

![Het originele PATH variable](/00_includes/path1.png)

Op de 3 ... wordt vervolgens de directory vermeld welke je in het path wilt zetten. In deze is dat /home/jeroen_/scripts. Hierdoor is het gehele commando:  
**export PATH=/home/jeroen_/scripts:$PATH**
![Het aangepaste PATH variable](/00_includes/path2.png)

### *"3: Create a script that appends a line of text to a text file whenever it is executed"*

Hiervoor is het nodig om een bestand aan te maken met daarin een 2 onderdelen: een *shebang* en het script.

Een **shebang** geeft aan dat de file een script is en met welke shell deze gelezen moet worden en bestaat uit een #! en het volledige pad naar de shell binairy. Dus in dit geval:  
**#!/bin/bash**
Na het aanmaken van een script is het nodig deze execute permissions te geven; dit gaat via   
 **chmod u+x** 
![Added execute permissions](/00_includes/script_own.png)



Het script voor deze deelopdracht redelijk simpel: deze bestaat uit een echo en een redirect naar een andere file via de >> operator. Het commando binnen het gehele script is dan:  
**echo "This text is added to the opdracht7.sh script" 1> append.txt**

![Het script](/00_includes/nano_script.png)
*het script*

![De originele file](/00_includes/append_original.png)
*de originele inhoud*

![De appended file](/00_includes/append_appended.png)
*de aangepaste inhoud*

### *"4:Create a script that installs the httpd package, activates httpd, and enables httpd"**

Binnen deze deelopdracht zijn er meerdere onderdelen benodigd voor het script:
- Het installeren van een programma; in deze het httpd package
- Het starten van httpd; dit is het apache2 package
- Het enabelen van de daemon

 Voor de installatie van een package wordt in Ubuntu het **apt package** gebruikt. Je geeft hierbij het programma op dat je wilt installeren; in deze is dat apache2. Daarnaast moet je apt toestemming geven om iets te installeren; dit kan vooraf door het argument **-y** mee te geven.  
 Dit betekent dat het commando voor het installeren van het apache2 package dit moet zijn:  
   **apt install apache2 -y**

 Voor het starten van de service wordt op een systeem dat **systemd** als initialization daemon kent wordt het het commando ***systemctl** gebruikt om services te bheren. Deze kent een aantal opties voor dit beheer:
 - start -> start de service
 - stop -> stopt de service
 - pauze -> pauzeert de service
 - restart -> herstart een service nadat deze gepazeerd was
 - enable -> laat de service starten bij een systemboot
 - disable -> laat de service niet (meer) started bij een systemboot

 In deze moet de service gestart worden met **systemctl start** en enabled worden met **systemctl enable**; met in beide gevallen de service als laatste argument. De gehele commando's zijn dan:  
 **systemctl start apache2**  
 **systemctl enable apache2** 

![Het gehele script](/00_includes/script_installer.png)
*Het gehele script*

# Opdracht naam
Deze opdracht gaat over

Binnen deze opdracht worden de volgende n deelopdrachten gevraagd:

*

### *"n: "*