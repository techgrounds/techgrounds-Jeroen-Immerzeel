# SEC-07 Passwords

# Key-terms
- MD5
- Hashing
- Rainbow Tables
- Salted hashes

# Opdracht

De opdracht vraag het volgende:
- Find out what hashing is and why it is preferred over symmetric encryption for storing passwords.
- Find out how a Rainbow Table can be used to crack hashed passwords.
- Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table.  
**03F6D7D1D9AAE7160C05F71CE485AD31**  
**03D086C9B98F90D628F2D1BD84CFA6CA**
- Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table.
Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes.

# Gebruikte bronnen
Hashing:
https://www.wired.com/2016/06/hacker-lexicon-password-hashing/ voor wat hashing is  
Rainbow Tables:  
https://crackstation.net/ voor het cracken van de hashes in deelopdracht 3
https://www.educative.io/answers/what-are-rainbow-tables voor wat rainbowtables zijn

Salting:  
https://www.techtarget.com/searchsecurity/definition/salt

En voor het extra stuk:  
https://www.youtube.com/watch?v=z4_oqTZJqCo 

# Ervaren problemen

# Resultaat

*"1: Find out what hashing is and why it is preferred over symmetric encryption for storing passwords."

Hashing is een "one-way" wiskundige omzetting van een string in een string willekeurige tekens. Dit wordt gedaan om zo de originele string (vaak een wachtwoord) onleesbaar te maken alvorens deze op te slaan. Op deze manier wordt een wachtwoord niet leesbaar vezonden en opgeslagen.


Het voordeel van hashing over symmetrische encryptie zit 'm in het feit dat hashes niet kunnen worden terug veranderd in de originele input waar dit bij symmetrische encryptie juist wel kan. 


"*2: Find out how a Rainbow Table can be used to crack hashed passwords."*

Een rainbow table is een lijst met hashes van bekende wachtwoorden. Dit zijn vaak lijsten van duizenden gelekte wachtwoorden die omgezet zijn naar de verschillende hash functies.


*"3: Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table."*  
Hash 1: **03F6D7D1D9AAE7160C05F71CE485AD31**  
Hash 2: **03D086C9B98F90D628F2D1BD84CFA6CA**


Dit kan je doen op een website als https://crackstation.net/, maar ook met een programma als Hashcat (op Linux). 
Als we op de crackstation-website hash 1 ingeven krijgen we als output:
```welldone!```  
Als we op de crackstation-website hash 2 ingeven krijgen we als output:  
```result not found```

![Hash 1: "welldone!"](/00_includes/Networking_Images/md5_welldone.png)

![Hash 2: no result](/00_includes/Networking_Images/hash_not_found.png)


*"4_1: Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table."

Dit zal geen resultaten geven; de hashing die Linux uitvoert op de wachtwoorden is met "salting" en daardoor is het voor de crackstation-website zelfs niet duidelijk welk algoritme er gebruikt is.


*"4_2: Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes."*

Als we hetzelfde wachtwoord (MD5S) gebruiken op 2 accounts zullen beide wachtwoorden er anders uitzien. 
De ene heeft als hash:
$6$XRvB4asA9VPgjKYa$8KfH0eNXrB5r3xLFNJSl5I0.JQVMdIUsmL1b7v4NLn4xVBh.Kx8H35nKDS/ce.pRjaVJ7jE8rSuWhjyUcPOMV0

De ander heeft als hash:
$6$U/HcvieHYwy8i.6B$BZYBhGLJHSL9I8WeYiivbyy1vk4YJtS9iSf7101ljjQFMQZqA2n1mLRY8BR9nySBNglPvyiwdM59xk6QdgYmM.

## Extra punt: goede wachtwoorden zijn moeilijk te maken 

### Password cracking op meer gespecialiseerde wijze.

Het bovenstaande laat zien dat hashing door rainbow tables gebroken kan worden mits de hashes niet salted zijn. Echter kan een salted wachtwoord dat niet in een rainbow table staat alsnog gebroken worden; en dat door meer krachtige tools.

Zo kunnen programma's als **hashcat** en **hydra** ondanks de hashing en salting van Linux wachtwoorden, deze wel kraken.

**Hydra** gebruikt hierbij een lijst met wachtwoorden om een zogehete "dictionary attack" uit te voeren waarbij het programma een lijst met wachtwoorden (een "wordlist") gebruikt. Dit is bijna hetzelfde als een raindbow table, echter worden hierbij de niet-gehashte wachtwoorden gebruikt. Hydra werkt de wachtwoorden in de wordlist af bij inlog-pogingen totdat er 1 goed blijkt te zijn.

Dit heeft als nadeel dat als er een goed werkende firewall of IDS/IPS is, de aanval zal worden ontdekt en deze zal worden gestopt. 

**Hashcat** werkt in tegenstelling tot hydra offline. Deze tool is erg bruikbaar bij gelekte combinaties van usernames en gehashde wachtwoorden.
Hashcat kan namelijk wachtwoorden niet alleen hashen met MD5 of SHA-256, maar ook direct de salting meenemen. En deze heeft daarvoor een groot aantal opties.

Het enige nadeel is dat deze alleen werkt als men een gelekte database met usernames en wachtwoorden heeft; maar dat is in deze tijd van vele datalekken niet echt een probleem. Daarom is het gebruik van hetzelfde wachtwoord ook zo'n probleem.

En dat zijn puur simpele programma's; een AI kan dit nog sneller.

## Waarom langere wachtwoorden veiliger zijn

Hoewel men met rainbow tables en gespecialiseerde tools wachtwoorden kan kraken, zijn dit geen middelen met beperkingen. Zo zijn langere wachtwoorden moeilijker om te kraken; of ze nu gehashed zijn of niet. En het is ondoenbaar om elk wachtwoord in een rainbow table of wordlist te plaatsen.

Tijd is dan ook de meest beperkende factor.  
De regel is dat de complexiteit van een wachtwoord wordt bepaald door het aantal verschillende tekens tot de macht van het aantal tekens:
10 cijfers * lengte -> 4 cijfers -> 10^4 -> 10.000 mogelijkheden.
26 letters * lengte -> 4 letters ->  26^4 -> 456.976 mogelijkheden
62 alfanumerieke tekens * lengte > 4 tekens -> 62^4 -> 14.7 miljoen mogelijkheden

Het kraken van een wachtwoord met alleen 4 cijfers is dus zelfs met de hand makkelijk te doen; waar een wachtwoord bestaande uit alleen 4 hoofdletters al een stuk moeilijker is.

De lengte van een wachtwoord is echter belangrijker; 10^12 is veel meer dan 62^6 ->  1.000 miljard vs 56.8 miljard.
En daar zit het probleem: mensen kunnen een wachtwoord van zulke lengte niet goed onthouden. Hierdoor gebruikt men veelal dezelfde wachtwoorden en dat is zoals we hebben gezien niet veilig.


![Time to crack a password](/00_includes/Networking_Images/time_to_crack.png)
*de tijd die een AI nodig heeft om een wachtwoord te kraken*
## Alternatieven voor wachtwoorden
Er zijn goede oplossingen om wachtwoorden te vervangen, of aan te vullen.
MFA is een bekend voorbeeld: je moet hierbij een extra stap doorlopen alvorens je kan inloggen.

Maar op dit moment is er een revolutie gaande: de **passkeys**.
Passkeys zijn de facto een MFA oplossing waarbij men moet inloggen via een app met biometrie, pattern of PIN, maar veel geavanceerder. Deze gebruiken namelijk een public/private key certification systeem waarbij de gebruiker inlogt op diens app en de app inlogt op het systeem dmv een digitaal certificaat.
Bij dit systeem is er dus geen sprake van een wachtwoord, maar een beveiligingslaag in de vorm van de app en het device waarop deze app staat.

Dit alternatief wordt dan ook de toekomst; deze is beter beveiligd, en simpeler in het gebruik voor de user en de developers/systeembeheerders.


