# Linux Opdrachten

Dit zijn alle Linux opdrachten samengevoegd.

## Keyterms:
- Linux
- ssh
- PKI
- Whoami
- cd
- ls
- echo
- 

## Welke problemen ben ik tegengekomen?

### Opdracht LNX-01 Setting up:
Voor het verbinden met de Linux container heb ik het ssh commando binnen Windows CMD.exe gebruikt.
Het complete commando in deze is:
**ssh -p 52202 -i "C:\Users\jimme\OneDrive\Bureaublad\Nest-je-Immerzeel.pem jeroen_@3.121.130.219**

![ssh commando]

##### whoami
De opdracht vraagt om het whoami commando te gebruiken; deze geeft in mijn geval jeroen_ als output.

![whoami]

### Opdracht LNX-02 Files and directories

De volgende opdracht vraagt om de volgende 5 dingen:
- Find out your current working directory.
- Make a listing of all files and directories in your home directory.
- Within your home directory, create a new directory named ‘techgrounds’.
- Within the techgrounds directory, create a file containing some text.
- Move around your directory tree using both absolute and relative paths.

##### Find out your current working directory.
Voor deze eerste deelopdracht wordt het **pwd** commando gebruikt. Deze geeft als output: **/home/jeroen_**

![pwd commando]

##### Make a listing of all files and directories in your home directory.
Voor de tweede deelopdracht wordt het **ls** commando gebruikt. Deze geeft als output niets; er zijn geen niet-verborgen bestanden. Met **ls -a** wordt de output:
**. .. .bash_history .bash_logout .bashrc .cache .profile .ssh**

![ls -a output]


Voor het **ls** commando zijn ook een aantal extra argumenten:
-a      Laat alle bestanden zien, inclusief de verborgen bestanden.
-l      Geeft een "long listing" waarbij er extra informatie als... wordt getoond.
-h      Maakt de filesize output van -l "humanreable".
-R      Recursive listing: dit laat ook de inhoud van onderliggende mappen zien. 

##### "Within your home directory, create a new directory named ‘techgrounds’"
Voor de derde deelopdracht wordt het **mkdir** commando gebruikt.
Deze kent een aantal argumenten die handig zijn:
-p      Maakt, als het nodig is, ook direct parent folders aan.
-v      Verbose; geeft een melding weer over wat het commando heeft gedaan.


![De output van mkdir]
##### "Within the techgrounds directory, create a file containing some text."
Voor deze vierde deelopdracht wordt het **echo** commando gebruikt.
Deze heeft als standard output de tekst die je zelf opgeeft. Door deze output met een **\>**  te redirecten naar een nog niet bestaande file wordt deze file aangemaakt met de ogegeven tekst als inhoud.
In deze is het commando:  
**echo 'By redirecting an echo to a new file you can simply create a new file with the contents you want. This is only one way out of many to do this' > textfile2**




![De output van Echo]

##### Move around your directory tree using both absolute and relative paths.
Voor de vijfde deelopdracht wordt het **cd** commando gebruikt.

Bij het gebruik van een absolute path wordt het gehele pad naar een folder opgegeven. Dus **cd /etc/ssh** zal je verplaatsen naar de **/etc/ssh folder**.

Bij het gebruik van een relative path geef je de route aan via welke je naar een folder moet nemen. Dus als je in de **cd /etc/ssh** folder bent en je **cd ../X11** ingeeft zal je eerst 1 maplaag terug gaan en daarna naar de /etc/X11 map worden gestuurd.
 
**cd** heeft als andere veelgebruikte opties om door het bestandssysteem te lopen:
- ..       Ga 1 map omhoog
- ..\/..   Ga 2 mappen omhoog; elke /.. voegt een extra laag toe.
- \~       Ga naar je /HOME folder
- \/       Ga naar de root van het bestandssysteem.


## Opdracht LNX-03 
Deze opdracht gaat over de standard input en output.
Binnen deze opdracht worden de volgende deelopdrachten gevraagd:
- Use the echo command and output redirection to write a new sentence into your text file using the command line. The new sentence should contain the word ‘techgrounds’.
- Use a command to write the contents of your text file to the terminal. Make use of a command to filter the output so that only the sentence containing ‘techgrounds’ appears.
- Read your text file with the command used in the second step, once again filtering for the word ‘techgrounds’. This time, redirect the output to a new file called ‘techgrounds.txt’.

Voor de eerste deelopdracht is het commando:
**echo file >> Leren via techgrounds is erg leuk.**

![echo commando]

Voor de tweede deelopdracht zijn de commando's **cat** en **grep** nodig alsmede de pipe \| om de output van **cat** door te sturen naar **grep** voor filtering.
Hiermee is het te gebruiken commando:
**cat file | grep "techgrounds"**

![De output van Cat en Grep ]

Voor de derde deelopdracht moet er weer gewerkt worden met redirection via >>, maar dan na het filteren met **grep**.
Hiermee is het te gebruiken commando:
**cat file | grep "techgrounds" >> techgrounds.txt**


