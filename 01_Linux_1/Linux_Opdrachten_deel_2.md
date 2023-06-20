# Linux opdrachten 5 tot en met 7
*Dit zijn de opdrachten 5 tot en met 7 voor Linux samengevoegd*

## Key-terms:
- Permissions
- File beheer
- Bash scripting
- PATH enviroment variable
- Shebang
- Service beheer
- Systemctl
- Apt suite
- Command substitution

## Bronnen
Het boek "LPIC-1 Study Guide Fifth Edition" waarin ik de meeste oplossingen gevonden heb.  
https://www.gnu.org/software/bash/manual/ en specifiek https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html voor een aantal vragen.  
https://www.howtoforge.com/how-to-install-and-use-telnet-on-ubuntu/ voor het installeren van de telnet service voor opdracht 6.  
https://linuxhint.com/generate-random-number-bash/ voor de informatie over het aanmaken van een random number.  

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
Deze opdracht is simpel en kan op meerdere manieren worden uitgevoerd:
- ```echo "tekst" > file.txt```
- ```touch > file.txt```
- met een tekst editor als VIM, Nano of Emacs 

Wat ook leuk is om te weten is dat in Linux elke file een tekstbestand is, en dat een extensie niet nodig is; deze zijn er puur voor de gebruiker om snel te zien waarvoor een bestand gebruikt wordt. 

![Het aanmaken van een tekstfile](/00_includes/linux/permissions_1.png)  
*aanmaken van een tekstfile*

### *2: Make a long listing to view the file’s permissions. Who is the file’s owner and group? What kind of permissions does the file have?*

Deze deelopdracht kent een aantal onderdelen:
- Het maken van een long-listing.
- Het bepalen van de owner en group van de file aan de hand van de output van de long-listing.
- Het bepalen van de permissions.

**Het maken van een long listing:**  

Een *long listing* maken gaat via het **```ls -l```** commando.

![Long listing van de aangemaakte permissions.txt](/00_includes/linux/permissions_ls.png)  
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
Read geeft permissions om de inhoud van de file te lezen.
Write geeft permissions om de inhoud van een file aan te passen.
Execute geeft de permissions tot het uitvoeren van de file als zijne een binary of script.

Directories:
Read geeft permissions om de inhoud in de directory te bekijken.
Write geeft permissions om het aanpassen van de files in de directory.
Execute geeft permissions om de directory als working directory te gebruiken, dit zolang dit ook geldt voor parent directories.
```

## *"3: Make the file executable by adding the execute permission (x)."*

*Ik ga hierbij vanuit dat het gaat om de execute permission voor de user.*

Het aanpassen van de permissions op een file of directory gaat via het **```chmod```** commando.
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
 **```chmod 763 permissions.txt```**

![Permissions aanpassen met octal mode](/00_includes/linux/permissions_user_octal.png)  
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

Het is hierbij mogelijk om zowel de user/group/others als de permissions te combineren; dus ```ugo=rwx``` is gewoon mogelijk.

Hierdoor is het uiteindelijke commando voor de opdracht:  
**```chmod u+x permissions.txt```**

![permissions aanpassen met chmod u+x](/00_includes/linux/permissions_user_x.png)  
*symbolic mode*

## *"4: Remove the read and write permissions (rw) from the file for the group and everyone else, but not for the owner. Can you still read it?*"

Dit wordt ook weer gedaan met het **```chmod```** commando.
In deze moet het gehele commando 1 van deze 2 commando's zijn:  
**```chmod 600 permissions.txt```**  
**```chmod go-rwx permissions.txt```**

![Permissions verwijderen via octal mode](/00_includes/linux/permissions_remove_octal.png)  
*octal mode*  

<br>

![Permissions verwijderen via symbolic mode](/00_includes/linux/permissions_remove_symbolic.png)  
*symbolic mode*

Na het verwijderen van de rechten voor de group en others kan de user deze nog altijd lezen; de read permission van de user er is immers nog altijd.

![De user heeft nog altijd read permissions](/00_includes/linux/cat_permissions.png)  
*read permission user*

### *"5: Change the owner of the file to a different user. If everything went well, you shouldn’t be able to read the file unless you assume root privileges with ‘sudo’. "*

Dit gaat via het **```chown```** commando. Deze heeft een zeer simpele syntax:  
**```chown [OPTIONS] NEWOWNER FILE(s)```**

Dus om de user JBond de eigenaar te laten worden van de permissions.txt file is het commando:  
**```chown JBond permissions.txt```**

![Chown JBond permissions.txt](/00_includes/linux/change_ownership_user.png)    
*JBond is de nieuwe owner*
<br>

![De user jeroen_ kan de file niet lezen](/00_includes/linux/cat_permission_denied.png)    
*Geen read permissions, dus "permission denied"*
<br>
<br>

### *"6: Change the group ownership of the file to a different group."*

Ook dit is redelijk simpel en gaat via het **```chgrp```** commando. Deze kent eigenlijk dezelfde syntax als **```chown```**:  
**```chgrp [OPTIONS] NEWGROUP FILENAME(s)```**

Dus om de group "admin" de group te laten worden die eigenaar is van permissions.txt is het commando:  
**```chgrp admin permissions.txt```**

![De group was jeroen_](/00_includes/linux/group_owner_jeroen.png)  
*De group was jeroen_*


![De group na chgrp is admin](/00_includes/linux/group_owner_admin.png)  
*De group is nu admin* 



# Opdracht LNX-06

Deze opdracht gaat over het beheer van processen.

Binnen deze opdracht worden de volgende 4 deelopdrachten gevraagd:
- Start the telnet daemon.
- Find out the PID of the telnet daemon.
- Find out how much memory telnetd is using.
- Stop or kill the telnetd process.

## *"1: Start the telnet daemon"*
Een deamon is een "system service" dat er voor zorgt dat andere programma's bepaalde taken kunnen uitvoeren. Zo heeft een print-daemon de taak om het printen mogelijk te maken. 

Voor het starten van de service wordt op een systeem dat **systemd** als initialization daemon kent wordt het het commando **systemctl** gebruikt om services te beheren. Deze kent een aantal opties voor dit beheer:
```
start -> start de service
stop -> stopt de service
pauze -> pauzeert de service
restart -> herstart een service nadat deze gepazeerd was
enable -> laat de service starten bij een systemboot
disable -> laat de service niet (meer) starten bij een systemboot
```
Dus om de telnet daemon te starten moet **systemctl start inetd** worden gebruikt; **inetd** is daarbij de daemon die telnet gebruikt.
Echter, het telnet package is niet geinstalleerd dus zal deze eerst moeten worden geinstalleerd, wat kan via **apt install telnetd**.  
Na installatie wordt de daemon automatisch gestart.
 
![Het inetd service status na installatie](/00_includes/linux/inetd.png)
*inetd service*


## *"2: Find out the PID of the telnet daemon."*

Een PID is een Process ID, en elk process heeft er 1.  
Om te bekijken welke processen er actief zijn wordt het commando **```ps```** gebruikt. Deze zal zonder argumenten alleen die processen laten zien die de huidige user gebruikt. Dit is vaak alleen de shell en het ps commando zelf.  
Om alle lopende processen te bekijken wordt vaak de combinatie **```aux```** gebruik als argument; deze combinatie van argumenten geeft een overzicht van alle processen van alle users.

In deze is het mogelijk om de output van **```ps aux```** te filteren met **```grep```** op de **```inetd```** service; dan wordt het commando:  
**```ps -aux | grep "telnetd"```**  

Dit is echter niet de meest elegante en snelle manier, en kan veel sneller via het **```pgrep```** commando. De **p** in deze staat voor **PID** en het **```pgrep```** commando vraagt een service als argument en geeft het **PID** als output.
In deze is het de makkelijkste manier om **```pgrep inetd```** te gebruiken; welke in mijn geval een PID aangeeft van 12510  

![Inetd PID](/00_includes/linux/pregp_inet.png)
*pgrep inetd*


## *"3: Find out how much memory telnetd is using."*

Voor deze opdracht is het gebruik van **```systemctl status inetd```** de meest snelle oplossing. De output van deze laat o.a het PID de memory-usage en CPU usage zien.
In mijn geval gebruikt de **```inetd```** deamon 864.0k memory.

![status inetd](/00_includes/linux/6_4_memory.png)  
*inetd memory*

## *"4:"Stop or kill the telnetd process."*

Ook hiervoor wordt **```systemctl```** gebuikt maar dan met het **```stop```** argument.
Het gehele commando is dan ook:  
 **```sudo systemctl stop inetd```**.

![inetd stopped](/00_includes/linux/inetd_stopped.png)
*inetd status dead*


# Opdracht LNX-07: Bash Scripting.

Deze opdracht gaat over de basis van Bash Scripting.

Binnen deze opdracht worden de volgende deelopdrachten gevraagd:

**Deel 1:**  
- Create a directory called ‘scripts’. Place all the scripts you make in this directory.
- Add the scripts directory to the PATH variable.
- Create a script that appends a line of text to a text file whenever it is executed.
- Create a script that installs the httpd package, activates httpd, and enables httpd
- Finally, your script should print the status of httpd in the terminal.

**Deel 2:**  
- Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file.

**Deel 3:**
- Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file only if the number is bigger than 5. If the number is 5 or smaller, it should append a line of text to that same text file instead.


**Problemen die ik ben tegengekomen:**  

De naam van de httpd package bleek apache2 te zijn; dat gaf we wel even wat tijd om te realiseren. Dit gold ook voor het inetd package voor de telnet opdracht.
Ook een fout maken met het PATH variable gaf mij wat problemen die ik met behulp van mijn boek en hulp van teamgenoot kon oplossen. Hier bleek het gebruik van full paths de oplossing te zijn. 

## Deel 1:

### *"1: Create a directory called ‘scripts’. Place all the scripts you make in this directory."*

Dit gaat simpel met **```mkdir```**.
Het volledige commando is:  
**```mkdir scripts```**

### *"2: Add the scripts directory to the PATH variable."*

Dit is iets meer complex dan opdracht 1, maar nog altijd redelijk simpel.  

Het PATH bestaat uit de locaties die Bash doorzoekt om commando's te zoeken voor het uitvoeren. Om een map of executable toe te voegen aan het PATH wordt dit basis commando gebruikt:  
**```export PATH=...:$PATH```**  
Op de 3 ... wordt vervolgens de directory vermeld welke je in het path wilt zetten. In deze is dat /home/jeroen_/scripts. Hierdoor is het gehele commando:  
**```export PATH=/home/jeroen_/scripts:$PATH```** 
  

![Het originele PATH variable](/00_includes/linux/path1.png)
*het originele PATH* 

 

![Het aangepaste PATH variable](/00_includes/linux/path2.png)
*het aangepaste PATH*

### *"3: Create a script that appends a line of text to a text file whenever it is executed"*

Hiervoor is het nodig om een bestand aan te maken met daarin 2 onderdelen: een *shebang* en het script.

Een **shebang** geeft aan dat de file een script is en met welke shell deze gelezen moet worden en bestaat uit een #! en het volledige pad naar de shell binairy. Dus in dit geval:  
**#!/bin/bash**
 
Na het aanmaken van een script is het nodig deze execute permissions te geven; dit gaat via   
 **```chmod u+x```** 
![Added execute permissions](/00_includes/linux/script_own.png)
*write permission gegeven*



Het script voor deze deelopdracht redelijk simpel: deze bestaat uit een echo en een redirect naar een andere file via de >> operator. Het commando binnen het gehele script is dan:  
**```echo "This text is added to the opdracht7.sh script" 1> append.txt```**

![Het script](/00_includes/linux/nano_script.png)
*het script*

![De originele file](/00_includes/linux/append_original.png)
*de originele inhoud*

![De appended file](/00_includes/linux/append_appended.png)
*de aangepaste inhoud*

### *"4:Create a script that installs the httpd package, activates httpd, and enables httpd Finally, your script should print the status of httpd in the terminal."**

Binnen deze deelopdracht zijn er meerdere onderdelen benodigd voor het script:
- Het installeren van een programma; in deze het httpd package
- Het starten van httpd; dit is het apache2 package
- Het laten starten van de daemon tijdens het bootproces

**Het installeren van een package** 

 Voor de installatie van een package wordt in Ubuntu het **```apt package```** gebruikt. Je geeft hierbij het programma op dat je wilt installeren; in deze is dat apache2. Daarnaast moet je apt toestemming geven om iets te installeren; dit kan vooraf door het argument **```-y```** mee te geven.  
 Dit betekent dat het commando voor het installeren van het apache2 package dit moet zijn:  
   **```apt install apache2 -y```**

 
**Het starten en enabelen van een service**  

 Zoals in opdracht 6 al vermeld wordt in deze het **```systemctl```** commando gebruikt voor het beheer van deamons/services. 
 In deze moet de service gestart worden met **```systemctl start```** en enabled worden met **```systemctl enable```**; met in beide gevallen de service als laatste argument.   
 
 
**Het printen van de status van de apache2 service**  

 Om een de output van een commando te gebruiken als commando wordt *command substitution* gebruikt; hierbij wordt een commando tussen backticks gezet of tussn een dollarteken \$ en () gezet.
 Het command-substitution voor deze opdracht met het **```systemctl status```** commando moet dus **```$(systemctl status apache2)```** zijn.
 





Het gehele script is dan: 

```
#!/bin/bash  
sudo apt install apache2 -y  
sudo systemctl start apache2  
sudo systemctl enable apache2  
sudo echo systemctl status apache2
```
![Het gehele script](/00_includes/linux/script_7.png)  
*Het gehele script*

![De ouput van het script](/00_includes/linux/status_apache_7.png)  
*De status van de Apache service*


## *2:  Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file.* 

Deze opdracht kent meerdere onderdelen:
- Het laten aanmaken van een random number
- Het opslaan van dat nummer in een variable
- Het toevoegen van dat nummer aan een tekstfile

**Het aanmaken van een random number**  
Hiervoor is het nodig om wat te zoeken; de syntax is best lastig.
De oplossing welke ik vond is het commando echo **$((RANDOM % 10+1))** waar n1 het hoogste nummer is en n2 het laagste nummer is welke er gegeven kan worden. In deze is het commando om te gebruiken :
```
echo $((RANDOM % 10 + 1))
```

![Het $RANDOM command](/00_includes/linux/random1.png)  
*Het script*

**Het opslaan van een output als variable**  
Om de output van een commando op te slaan als variable wordt dus simpelweg variable = waarde. En om de output van een variable te tonen op de commandline wordt het **```echo```** commando gebruikt en het variabele voorafgegaan met een **$**. In deze wordt het commando om de random numbers op te slaan als variabele:
```
random_num=$[RANDOM %10+1]
```


En om deze te tonen is het **```echo $random_num```**  

![Een random number opslaan als variabele](/00_includes/linux/random_var.png)  
*Appending numbers*



**Het toevoegen van dat nummer aan een tekstfile**  
Deze is heel simpel: na het aanmaken van het eerdere script kan de output van deze worden doorgestuurd naar een andere file via de **>>** redirector. 
Hierbij wordt het **```echo $random_num```** deel van het script aangepast naar **```echo $random_num >> /home/jeroen_/scripts/random_num.txt```**

![Random_num](/00_includes/linux/random_added.png)  
*Het nummer appended*


### *"3: Create a script that generates a random number between 1 and 10, stores it in a variable, and then appends the number to a text file only if the number is bigger than 5. If the number is 5 or smaller, it should append a line of text to that same text file instead."*

Deze opdracht kent een aantal deel opdrachten:

- Het laten aanmaken van een random number tussen 1 en 10
- Het opslaan van dat nummer in een variable   

Deze 2 stappen zijn hetzelfde als in deelopdracht 2. 

Hierna komen er echter een aantal extra stappen:
- Alleen als het nummer groter is dan 5 moet dit nummer aan de textfile worden toegevoegd.
- Als het nummer kleiner is dan 5 moet er een tekstregel worden toegevoegd aan de textfile.


Hierbij moet er gebruik gemaakt worden van een *if* statement. Binnen bash is dit redelijk simpel en gaat dit schematisch gezien via:
```
if [ condition ]
then
  commands
fi
```
Ook moet er binnen deze opdracht 2 waardes met elkaar vergeleken worden: de output van de \$RANDOM functie en de gegeven voorwaarden uit de opdracht.
Voor het vergelijken van een nummerieke output worden er gebruik gemaakt van deze 6 tests:
```
eq -> equal to
ne -> not equal to
ge -> greater or equal to
le -> less or equal to
gt -> greater then
lt -> less then
```
In deze moet er gekeken worden of het getal gelijk of kleiner is dan 5 of groter is dan 5; dus is het nodig om de -le (less or equal) en -gt (greater then) tests te gebruiken. 
Hiermee worden de 2 *if* statements:

```
if [ *n* -le 5 ]
then
  commands
fi
```
en
 ```
if [ *n* -gt 5 ]
then
  commands
fi
```
En deze worden in 1 script samengevoegd.
Voor de rest is het script bijna hetzelfde als bij subopdracht 2:

```

random_num=$($RANDOM%10+1)
if [ $random_num -le 5 ]
then
  echo $random_num >> append_text.txt
fi

if [ $random_num -gt 5 ]
then
  echo "This number was higher then 5" >> append_text.txt
fi

```

![Het script in Linux](/00_includes/linux/random_append_script.png)  
*het script*

![De output van het script in het textfile](/00_includes/linux/random_append_append.png)  
*De output*

Ook is het mogelijk om met een *else* opdracht te werken; het script is dan wat korter en minder complex door "refactoring":
```

random_num=$($RANDOM%10+1)
if [ $random_num -le 5 ]
then
  echo $random_num >> append_text.txt
else
  echo "This number was higher then 5" >> append_text.txt
fi

```