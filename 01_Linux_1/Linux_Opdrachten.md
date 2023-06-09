# Linux Opdrachten

Dit zijn de eerste 4 Linux opdrachten samengevoegd.

## Keyterms:
- Linux
- ssh
- PKI
- Whoami
- pwd
- cd
- ls
- echo
- Redirection
- grep
- cat
- adduser
- useradd
- passwd
- passwd-file
- shadow-file


## Gebruikte bronnen:

- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html Voor de uitleg van het converteren van een .pem-file voor PuTTy
- Het boek "LPIC-1 Study Guide Fifth Edition" dat ik al had voor mijn MBO opleiding en waarin eigenlijk alle andere stof tot in detail wordt uitgelegd.


## Welke problemen ben ik tegengekomen?
Het enige wat echt even wat moeite gaf was het gebruik van een PKI binnen PuTTY; de stappen om een .pem file naar een .pkk file om te zetten zijn soms wat vaag.  
Een ander iet wat onhandig ding was de werking van adduser en useradd; ik wist dat 1 van de 2 heel barebones was, maar niet meer welke. Dit heb ik zelf uitgezocht door de commando's in kwestie te combineren met het --help argument.


# Opdracht LNX-01 Setting up:
Deze opdracht gaat over het inloggen op een VM/Container.  
Binnen deze opdracht worden de volgende 2 deelopdrachten gevraagd:
- Make an SSH-connection to your virtual machine. SSH requires the key file to have specific permissions, so you might need to change those.
- When the connection is successful, type whoami in the terminal. This command should show your username.

### *1: Make an SSH-connection to your virtual machine. SSH requires the key file to have specific permissions, so you might need to change those.*
Het inloggen op een remote machine kan op meerdere manieren waaronder:
- Het gebruik van een tool als PuTTY <https://putty.org/>
- Het **ssh**-commando. Deze werkt op elke versie van Mac en Linux en sinds Windows 10 versie 1709 ook op Windows. Binnen Windows 10 is dit een "optional feature" dat je kan installeren; binnen Windows 11 is dit automatisch toegevoegd.

In mijn geval heb ik voor het **ssh**-commando gekozen gezien ik Windows 11 gebruik.<br>
De syntax is voor alle SSH-clients is hetzelfde gezien het hier om een opensource programma gaat, namelijk **OpenSSH**

Het gebruikte commando is:  
````ssh -p 52202 -i "C:\Users\jimme\OneDrive\Bureaublad\Nest-je-Immerzeel.pem" jeroen_@3.121.130.219````

![ssh commando](/00_includes/Linux/cmd_commando_ssh.png)
*Het ssh commando binnen cmd*

Voor *PuTTy* werkt alles iets anders:
-  Hierin wordt binnen de GUI het IP adres en de port van de remote host op, en de benodigde credentials. 
- Bij het gebruik van een private key moet een .pem-file eerst omgetzet worden naar een ppk-file voor het gebruik binnen PuTTy. Hierbij wordt het PuTTy-gen programma gebrikt waarbij de binnen de optie "load existing private key file" de locatie van de .pem-file aan wordt gegeven (hierbij het filetype op "all files(*.*) zetten) en vervolgens gekozen wordt voor "save private key". 
- Binnen PuTTy wordt er binnen de tree in het linkerdeel van het scherm naar SSH > Auth > Credentials gegaan. Daar wordt voor "Private Key file for Authentication" gekozen en gewezen naar de private key file die gebruikt moet worden.
- Hierna kan op het session scherm een sessie worden gestard met de [open] button.
- Een handige tip hierij is om, voor het openen van een sessie, de settings eerst op te slaan onder "saved sessions" in het sessions scherm.

### *2: When the connection is successful, type whoami in the terminal. This command should show your username.*
Deze opdracht is zeer simpel en vraagt niets meer dan het **whoami**-commando in te geven; deze geeft als output de huidige username waaronder je ingelogd bent, in mijn geval **Jeroen_**.

![whoami](/00_includes/Linux/whoami.png)



# Opdracht LNX-02 Files and directories
Deze opdracht gaat over het beheren van files en directories.  

Binnen deze opdracht worden de volgende 5 deelopdrachten gevraagd:
- Find out your current working directory.
- Make a listing of all files and directories in your home directory.
- Within your home directory, create a new directory named ‘techgrounds’.
- Within the techgrounds directory, create a file containing some text.
- Move around your directory tree using both absolute and relative paths.

### *1: Find out your current working directory.*
Voor deze eerste deelopdracht wordt het **````pwd````** commando gebruikt.   
Deze geeft als output: **/home/jeroen_**

![pwd commando](/00_includes/Linux/pwd.png)

### *2: Make a listing of all files and directories in your home directory.*
Voor de tweede deelopdracht wordt het **```ls```** commando gebruikt. Deze geeft als output niets; er zijn geen niet-verborgen bestanden. Met **```ls -a```** wordt de output:  
**. .. .bash_history .bash_logout .bashrc .cache .profile .ssh**  


![ls -a output](/00_includes/Linux/ls_a.png)

Binnen de output zijn witte namen files, blauwe namen directories en met een . of .. wordt een bestand of directory verborgen. De gekleurde output is een optionele instelling; dit is een onderdeel van menig distribution maar kan in principe naar wens worden aangepast.

Als er geen colored-output gebruikt wordt kan worden gekeken of er sprake is van een directory of een file door **```ls -l```** te gebruiken en in de permissions te kijken of de eerst letter een d of een - is; een d geeft vervolgens aan dat het een directory is en een - dat het een file is.

Voor het **```ls```** commando zijn ook een aantal extra argumenten:  
```
-a      Laat alle bestanden zien, inclusief de verborgen bestanden.  
-l      Geeft een "long listing" waarbij er extra informatie als... wordt getoond.  
-h      Maakt de filesize output van -l "humanreable".  
-R      Recursive listing: dit laat ook de inhoud van onderliggende mappen zien.
```




### *3: "Within your home directory, create a new directory named ‘techgrounds’"*
Voor de derde deelopdracht wordt het **```mkdir```** commando gebruikt.  

Deze kent een aantal argumenten die handig zijn:  
```
-p      Maakt, als het nodig is, ook direct parent folders aan.  
-v      Verbose; geeft een melding weer over wat het commando heeft gedaan.
```


![De output van mkdir](/00_includes/Linux/mkdir.png)


### *4: "Within the techgrounds directory, create a file containing some text."* 
Voor deze vierde deelopdracht wordt het **```echo```** commando gebruikt.
Deze heeft als standard output de tekst die wordt opgegeven. Door deze output met een **\>**  te redirecten naar een nog niet bestaande file wordt deze file aangemaakt met de opgegeven tekst als inhoud.  

Voor de opdracht is het eerst nodig met met **```cd techgrounds```** naar de techgrounds folder te gaan en daarna dit commando te gebruiken: 
``` 
echo 'By redirecting an echo to a new file you can simply create a new file with the contents you want. This is only one way out of many to do this' > textfile2
```

![De output van Echo](/00_includes/Linux/echo.png)
*echo redirection*

### *"5: Move around your directory tree using both absolute and relative paths."*
Voor de vijfde deelopdracht wordt het **```cd```** commando gebruikt.

Bij het gebruik van een absolute path wordt het gehele pad naar een folder opgegeven. Dus **```cd /etc/ssh```** zal de work directory verplaatsen naar de **```/etc/ssh folder```**.

Bij het gebruik van een relative path wordt de route aangegeven welke leidt naar de gewilde directory. Dus als **```cd /etc/ssh```** de working directory is en **```cd ../X11```** wordt ingegeven wordt er eerst 1 niveau terug gegaan naar de **/etc/** directory (het **```cd ..```** deel van het commando) en daarna 1 niveau omhoog gegaan naar de **/etc/X11** directory (het **```cd /X11```** deel van het commando).
 
**```cd```** heeft als andere veelgebruikte opties om door het bestandssysteem te lopen:
```
 ..       Ga 1 niveau omhoog
 ../..   Ga 2 niveaus omhoog; elke /.. voegt een extra laag toe.
 ~       Ga naar je /HOME folder
 /       Ga naar de root van het bestandssysteem.
```


# Opdracht LNX-03 
Deze opdracht gaat over de standard input en output.  

Binnen deze opdracht worden de volgende 3 deelopdrachten gevraagd:
- Use the echo command and output redirection to write a new sentence into your text file using the command line. The new sentence should contain the word ‘techgrounds’.
- Use a command to write the contents of your text file to the terminal. Make use of a command to filter the output so that only the sentence containing ‘techgrounds’ appears.
- Read your text file with the command used in the second step, once again filtering for the word ‘techgrounds’. This time, redirect the output to a new file called ‘techgrounds.txt’.

### *1: "Use the echo command and output redirection to write a new sentence into your text file using the command line. The new sentence should contain the word ‘techgrounds’."*
Om een output naar een file weg te schrijven waarbij de originele inhoud blijft staan wordt de \>\> redirect operator gebruikt; dit in tegenstelling tot de \> operator welke de inhoud van een file vervangt.  

Dus voor deze deelopdracht is het commando:
**```echo "Leren via techgrounds is erg leuk" >> textfile2.txt```**

![echo commando](/00_includes/Linux/echo_redirect.png)
*echo >> output*

### *2: Use a command to write the contents of your text file to the terminal. Make use of a command to filter the output so that only the sentence containing ‘techgrounds’ appears.*

Om een tekst file te bekijken binnen de terminal wordt het **```cat```** commando gebruikt. Om de output van een ander commando te filteren, eventueel met reguliere expressies, wordt **```grep```** gebruikt in commbinatie met een "redirection pipe" om de output van **```cd```** tot input van **```grep```** te maken; deze wordt met een **\|** aangegeven.   
Daarom is het te gebruiken commando in deze:

**```cat textfile2 | grep "techgrounds"```**


![De output van Cat en Grep](/00_includes/Linux/grep_redirect.png)
### *"3: Read your text file with the command used in the second step, once again filtering for the word ‘techgrounds’. This time, redirect the output to a new file called ‘techgrounds.txt’."*
Voor de derde deelopdracht moet er weer gewerkt worden met een redirection via >> en een nieuwe file, maar dan ná het filteren met **```grep```**.
Hiermee is het te gebruiken commando:  
**```cat textfile2 | grep "techgrounds" >> techgrounds.txt```**

![Het aanmaken van een bestand met grep filtering en redirection](/00_includes/Linux/grep_redirect2.png)

Er is hierbij dan ook een belangrijk verschil tussen > en >>:   
\> vervangt de inhoud van het bestand waar naar toe verwezen wordt.  
\>\> vult het bestand waar naar toe verwezen toe aan met de gewilde output.

# Opdracht LNX-04

Deze opdracht gaat over het aanmaken en beheren van user accounts.  

Binnen deze opdracht worden de volgende 5 deelopdrachten gevraagd:
- Create a new user in your VM. 
- The new user should be part of an admin group.
- The new user should have a password.
- The new user should be able to use ‘sudo’
- Locate the files that store users, passwords, and groups. See if you can find your newly created user’s data in there.



### *"1: Create a new user in your VM"*


Dit is op eerste gezicht een heel simpele opdracht, maar kan wat moeilijker worden mocht het verkeerde commando worden gebruikt.
Er zijn namelijk 2 commando's die user acccounts aanmaken, en beiden werken net iets anders.

Deze 2 commando's zijn:
- ```adduser```
- ```useradd```    

Daarnaast zijn er per distribution verschillen in de configuraties van deze commando's.
Dit alles maakt de boel er niet simpeler op.

Het **adduser** commando.  
Dit commando wordt vooral op Debian based distributions gebruikt, waar Ubuntu ook onder valt. Dit omdat na het opgeven van een username er gevraagd wordt om relevante informatie zoals een password, maar ook een volledige naam en andere informatie.   
**```adduser```** maakt dus een compleet userprofile aan.


![Voorbeeld van het toevoegen van een user via adduser](/00_includes/Linux/adduser.png)  
*Het gebruik van adduser*

Het **useradd** commando.  
Dit commando maakt ook user accounts aan, maar dat is dan ook alles; useradd maakt dus geen /home-directory aan, noch een password of comments. Dit is tenzij je met argumenten gaat werken waarbij de volgende argumenten het meest belangrijk zijn:  
```
-m -> maak een home directory aan  
-d [HOME_DIRECTORY] -> maak een home directory aan op de opgegeven locatie.  
-p [PASSWORD] -> maak het aangegeven password aan  
-s [SHELL] -> laat de user standaard de opgegeven shell gebruiken  
-D -> print de default configuratie voor useradd
```
Dus om de user "jake" aan te maken en deze een een home directory te geven, is het commando dat je moet opgeven:  
**```useradd -m jake```**  

Om te controleren of **```useradd```** een home-directory heeft aangemaakt kan je **```ls /home | grep [username]```** gebruiken; geeft deze geen output dan is er geen home-directory voor de opgegeven user anders wordt de username de output. 


![useradd geeft zonder -m geen /home-directory](/00_includes/Linux/useradd_m.png)  
*Zonder het -m argument wordt er geen home-directory aangemaakt.*   


Met **```cat /etc/passwd | grep [username]```** kan worden gecontroleerd of een user bestaat.


![Grep /etc/passwd](/00_includes/Linux/grep_passwd.png)


### *"2: The new user should be part of an admin group."*

Elke user krijgt bij de creatie een eigen group.
Op deze VM is de group "admin" al aangemaakt; was dat niet het geval kon deze worden aangemaakt met het **```groupadd```** commando. 
Voor het toevoegen van een user aan een nieuwe group wordt het **```usermod```** commando gebruikt met het argument **```-G```**.   

Wat ook belangrijk is dat door het argument **```-a```** te gebruiken het lidmaatschap van andere groups wordt behouden; wordt **```-a```** niet gebruikt wordt het lidmaatschap van alle andere groups verwijderd en daarmee ook alle rechten behorende bij deze groups. Iemand verwijderen van een group zal diegene dus ook eventuele rechten tot files behorende tot deze groups doen verliezen.


Om de user JBond toe te voegen aan de admin group en zijn lidmaatschap van zijn eigen group te behouden is het commando: **```sudo usermod -aG JBond admin```**

![De groups waar JBond lid van was](/00_includes/Linux/JBond_group1.png)  
*De groups waar JBond lid van was*
![De groups waar JBond lid van is na **usermod**](/00_includes/Linux/JBond_group2.png)  
*De groups waar JBond lid van is na **usermod -aG***

### *"3: The new user should have a password."*

Een password aanmaken of aanpassen gaat met het passwd commando.
Door  **```sudo passwd [username]```** te gebruiken kan een password worden aangepast.
Door gebruik te maken van argumenten kan het passwd-commando ook de regels van passwords aanpassen, waaronder:
```
- -d verwijder password
- -e expire password en verplicht het aanmaken van een nieuw password bij login
- -S laat de status van een password zien
```

![Het gebruikt van passwd](/00_includes/Linux/passwd.png)

### *"4: The new user should be able to use ‘sudo’"*

Sudo, of *Super User Do* is een toevoeging aan een commando dat kan worden gebruikt om een commando met hogere rechten uit te voeren. Deze zet men dan altijd vóór elk ander deel van een commando.

Accounts die sudo mogen gebruiken moeten in de sudoers-file staan, en logischerwijs mogen alleen die accounts die in de sudoers-file staan deze aanpassen.

![Het gebruik van sudo voor accounts die niet in de sudoers-file staan geeft een foutmelding](/00_includes/Linux/su_sudoers.png)
*Oeps, geen toestemming*  
  
  ![Als iemand wel in de sudoers-file staat mag deze wel sudo gebruiken](/00_includes/Linux/JBond_sudo.png)
  *Nu wel toestemming*


Om de sudoers-file aan te passen moet **```sudo```** worden gebruikt en de **visudo** editor. 
Het toevoegen van een user aan de sudoers-file kent een redelijk simpele syntax: eerst de username, daarna de rechten.  
In deze zijn de rechten onderverdeeld in 2 delen: de rechten en het gebruik van een passwd. Als de rechten **ALL=ALL** zijn dan mag het account altijd sudo gebruiken; als de password regel **NOPASSWD=ALL** wordt gebruikt wordt er nooit om een password gevraagd. En zo zijn er meer opties die de regels betreffende het gebruik van sudo kunnen aanpassen.



![Het editen van de sudoers-file](/00_includes/Linux/sudoers_2.png)
*Het toevoegen van JBond in de sudoers-file*

### *"5: Locate the files that store users, passwords, and groups. See if you can find your newly created user’s data in there."*
Deze opdracht is redelijk simpel.  
Er zijn 3 files die deze data opslaan en alle 3 staan in de /etc/ directory:
- Het **passwd** -file. Deze bevat de userinformatioon, maar niet de password informatie.
- Het **shadow** -file. Deze bevat wel de password informatie, maar dan in een hash én is beter beveiligd; toegang wordt alleen verleend aan de root en/of sudo-users.  
- Het **group** -file. Deze bevat alle groups en de leden van elke group. 

In deze files wordt de informatie verdeeld in een .csv bestandstype.


![JBond in **passwd**](/00_includes/Linux/JBond_passwd.png)  
*De indelinng van het passwd-file*

![JBond in **shadow**](/00_includes/Linux/JBond_shadow.png)
*zonder sudo geen toegang tot het shadow-file*

![Het group -file](/00_includes/Linux/group_file.png)  
*De laatste 10 lines van het group-file*

