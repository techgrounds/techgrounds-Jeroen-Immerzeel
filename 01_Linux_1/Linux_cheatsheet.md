# Linux

# Mijn persoonlijk ervaring met Linux.
Voordat ik in 2019 begon met een IT studie had ik nooit echt met Linux gewerkt. Op het onbewuste in de vorm van IoT devices en Android smartphones na.
Zodra ik met Linux in aanraking kwam ging er echter een wereld aan kennis voor mij open. Nu had ik als kind wel gewerkt met DOS en wist dus wel wat van hoe een CLI werkt, maar Linux is toch een ander iets...
Na een aantal weken te oefenen, zowel zelf als met oefenmodules van o.a. codeacademy, was de basis al gelegd die we in deze training van Techgrounds ook kregen. En daar heb ik best veel aan. Ik heb nu op mijn laptop een dualboot met Windows en een Linux disto; waarvan ik de Linux distro het meeste gebruikt om er mee te oefenen. 1 van de dingen die ik daarbij standaard doe is in de grub config file ```/etc/default/grub``` de timeout setting aanpassen naar ```timeout=-1```; dit om zo het automatische starten van de standaard optie te voorkomen. 
Ook het oefenen van REGEX en Vim via ```Vimtutor``` zijn dingen die ik in het verleden regelmatig heb gedaan; het eerste ging mij echter beter af dan het tweede...

Nu wil ik graag ooit aan de slag in de Cybersecurity, en dan het liefste als pentester of ethical hacker, en dan is een basiskennis van de vele Linux-tools een must. Hierom ben ik juist ook begonnen met de trainingen van Hack the Box en Try Hack Me. Dit om zowel het plezier van het leren hacken, als de praktische kennis die ik kan gaan gebruiken in mijn toekomstige werk.
___

# Wat willekeurige stukken over Linux.
(dit zal ik in de loop der tijd nog aanvullen)


# CLI, commandos en GUI's.
 Linux maakt veelal gebruik van een *command line interface* of *cli* waarbij er via tekstcommandos handelingen worden uitgevoerd.
 Er zijn ook grafische interfaces, oftewel GUIs. Dit zijn er steeds meer, en de kwaliteit van de grafische oplossingen is al een tijd behoorlijk goed, maar toch wordt het meeste werk in de praktijk nog altijd het meeste gedaan via de cli.  

# Commandos

Er zijn letterlijk duizenden mogelijke commandos en elk programma heeft er dan wel een fiks aantal. Er is echter wel een set basiscommandos die elke distributie gebruikt.
Een belangijk ding is, dat als je meer wilt weten over een commando je (bijna) altijd het commando en ```--help``` kan gebruiken om de syntax van een commando te bekijken; dus bijvoorbeeld ```adduser --help``` zal je informatie geven om het commando ```adduser```
Hiernaast kan je via de **man -pages** ( “manual pages”) informatie krijgen; hiervoor is het commando simpelweg ```man <command>``` bijvoorbeeld ```man adduser``` 

Een kleine lijst met belangrijke commandos is:
-	ls
-	cat
-	pwd
-	adduser
-	grep
-	echo
-	ps
-	usermod
-	passwd
-	chown
-	mkdir
-   touch
-	cd
-	chgrp
-	systemctl
-   apt (install/update/upgrade)

Termen die ook van belang zijn als onderdeel van hoe Linux en commandos werken zijn:
-	redirection
-	piping via een |
-	configuration files
-	permissions
-   flags/arguments
-   path
-   textediting 


# Extra Linux informatie
## File system
Linux kent een heel andere manier van het beheer van het filesystem dan Windows.
In linux de start van het filesystem heet de "root" en wordt genoteerd met ```\``` vanaf hier loopt de directory als een boomstructuur met als eerste directories een gestandardiseerde mapstructuur genaamd het "Filesystem Hierarchy Standard" of "FHS".
Een aantal van de standaard mappen zijn:
```
/home: home-directory voor gebruikers
/usr: secundaire opslag voor user data
/bin: essential system binaries
/sbin: essentiële system binairies
/etc: locatie voor configuration files (soms als "etc" en soms als "edit to configure" uitgelegd)
/dev: voor device files (disks, ) 
/opt: voor optionele programma's
/boot: boot files
/lib: library bestanden voor binaries
/proc: pseudo filesystem dat device informatie bij houdt.
/var: variable files c.q. bestanden die snel veranderen
/mnt: mountpunt voor tijdelijke filesystems die geen onderdeel zijn van het standaard gebruikte filesystems
/media: mountpunt voor removable media als USB devices
```

Het filesystem kan een aantal typen filesysteem gebruiken waaronder NFS, Ext1 - 4, Fat, btrfs, XFS en Swap.
Van deze is swap een bijzonder types: dit is het filesystem dat gebruikt wordt als extra geheugen ter aanvulling van het RAM geheugen.

Voor het aansluiten van een (tijdelijk) filessysteem of wisselbare opslag als een USB stick wordt het /mount commando gebruikt. Door dit systeem kan er heel snel en simpel gebruik gemaakt worden van deze opslagplaatsen. 

# Linux Distributies
Linux is, in tegenstelling tot Windows en MacOS, niet een door een bedrijf uitgegeven besturingssysteem maar de *Kernel*; het hart van een besturingssysteem dat de hardware aanstuurt en de software de nodige toegang verleent tot de hardware. 
Een distributie is juist wel een volledig besturingssysteem met als basis de Linux kernel. Om de kernel heen wordt een software package gemaakt; vaak gaat het hier om de software van de GNU project (een grote collectie "free software"), een *init systeem*, *package manager* en meer.

Een aantal grote distributies zijn:
- Red Hat Enterprise Linux, RHEL
- Debian
- Ubuntu
- Arch
- Mint


# Waarom is Linux zo belanrijk en groot?
De Linux kernel is in 1991 bedacht door Linus Torvalds als alternatief voor Minix; een besturingssysteem dat niet aangepast mocht worden en behoorlijk achter liep op de toen bestaande hardware.
Volgens Linus Torvalds zelf werd Linux pas echt populair toen in 1992 het X Windows system naar Linux werd geport en er een GUI kon worden gebruikt.

Linux is, in mij optiek, echter echt groot geworden doordat dit een lightweight, open source, free to use kernel is. De kernel is dus zeer efficiënt, en iedereen mag er dus veranderingen in aanbrengen, al moet men dan wel (onder de GPLv2 licenttie) deze veranderingen openbaar maken. Dit betekent uiteindelijk dat de kernel door velen kan worden gecontroleerd op veiligheidslekken. En dat Linux hierdoor extreem aanpasbaar is en er dus heel veel verschillende distributies zijn, maakt het uiteindelijk zo dat de kernel in extreem veel scenario's de beste oplossing is.





