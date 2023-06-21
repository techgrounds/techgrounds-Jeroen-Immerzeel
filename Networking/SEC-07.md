# SEC-07 Passwords

# Key-terms
- MD5
- Hashing
- Rainbow Tables
- Salted hashes
- Extra stof

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
Geen. Dit was letterlijk "right up my alley".
# Resultaat

## *"1: Find out what hashing is and why it is preferred over symmetric encryption for storing passwords."

Hashing is een "one-way" wiskundige omzetting van een string in een string willekeurige tekens. Dit wordt gedaan om zo de originele string (vaak een wachtwoord) onleesbaar te maken alvorens deze op te slaan. Op deze manier wordt een wachtwoord niet leesbaar vezonden en opgeslagen.


Het voordeel van hashing over symmetrische encryptie zit 'm in het feit dat hashes niet kunnen worden terug veranderd in de originele input waar dit bij symmetrische encryptie juist wel kan. 


## "*2: Find out how a Rainbow Table can be used to crack hashed passwords."*

Een rainbow table is een lijst met hashes van bekende wachtwoorden. Dit zijn vaak lijsten van duizenden gelekte wachtwoorden die omgezet zijn naar de verschillende hash functies.

Dus als je een gehashde wachtwoord wilt kraken gebruik je een website zoals https://crackstation.net of software om de hash van het wachtwoord te vergelijken met bekende hashes in de rainbow tables.  


## *"3: Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table."*  
Hash 1: **03F6D7D1D9AAE7160C05F71CE485AD31**  
Hash 2: **03D086C9B98F90D628F2D1BD84CFA6CA**


Dit kan je doen op een website als https://crackstation.net/, maar ook met een programma.

Als we op de crackstation-website hash 1 ingeven krijgen we als output:  
```welldone!```  
Als we op de crackstation-website hash 2 ingeven krijgen we als output:  
```result not found```

![Hash 1: "welldone!"](/00_includes/Networking_Images/md5_welldone.png)
*resultaat van hash 1* 
![Hash 2: no result](/00_includes/Networking_Images/hash_not_found.png)
*resultaat van hash 2*


## *"4_1: Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table."

Dit zal geen resultaten geven; het hashing algoritme dat Linux uitvoert op de wachtwoorden gebruikt "salting" en daardoor is het voor de crackstation-website zelfs nieteens duidelijk welk algoritme er gebruikt is.


## *"4_2: Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes."*

Als we hetzelfde wachtwoord (MD5S) gebruiken op 2 accounts zullen beide wachtwoorden er anders uitzien. 
De ene heeft als hash:
$6$XRvB4asA9VPgjKYa$8KfH0eNXrB5r3xLFNJSl5I0.JQVMdIUsmL1b7v4NLn4xVBh.Kx8H35nKDS/ce.pRjaVJ7jE8rSuWhjyUcPOMV0

De ander heeft als hash:
$6$U/HcvieHYwy8i.6B$BZYBhGLJHSL9I8WeYiivbyy1vk4YJtS9iSf7101ljjQFMQZqA2n1mLRY8BR9nySBNglPvyiwdM59xk6QdgYmM.
___

## Extra punt: goede wachtwoorden zijn moeilijk te maken 

### Password cracking op meer gespecialiseerde wijze.

Het bovenstaande laat zien dat hashing door rainbow tables gebroken kan worden mits de hashes niet salted zijn. Echter kan een salted wachtwoord dat niet in een rainbow table staat alsnog gebroken worden; en dat door meer krachtige tools.

Zo kunnen programma's als **hashcat** en **hydra** ondanks de hashing en salting van Linux wachtwoorden, deze wel kraken.

**Hydra** gebruikt hierbij een lijst met wachtwoorden voor een zogehete "dictionary attack" waarbij het programma een lijst met wachtwoorden (een "wordlist") gebruikt. Dit is bijna hetzelfde als een raindow table, echter worden hierbij de niet-gehashte wachtwoorden gebruikt. Hydra werkt de wachtwoorden in de wordlist 1 vopor 1 af bij inlog-pogingen totdat er 1 goed blijkt te zijn.

Dit heeft als nadeel dat als er een goed werkende firewall of IDS/IPS is, de aanval zal worden ontdekt en deze zal worden gestopt. 

**Hashcat** werkt in tegenstelling tot hydra offline. Deze tool is erg bruikbaar bij het kraken van gelekte combinaties van usernames en gehashde wachtwoorden.
Hashcat kan namelijk wachtwoorden niet alleen hashen met MD5 of SHA-256, maar ook direct de salting meenemen. En deze heeft daarvoor een groot aantal opties.

Het enige nadeel is dat deze alleen werkt als men een gelekte database met usernames en wachtwoorden heeft; maar dat is in deze tijd van vele datalekken niet echt een probleem. Daarom is het gebruik van hetzelfde wachtwoord ook zo'n probleem.

En dat zijn nog simpele programma's; een AI kan dit nog veel sneller. Zo meldt ZDNet dat een AI genaamd PassGAN de meeste wachtwoorden, ongeacht lengte of complexiteit, binnen een realistisch tijdsbestek kan breken. Echter geldt ook hier dat langere en/of meer complexe wachtwoorden het moeilijkste zijn om te kraken.  
https://www.zdnet.com/article/how-an-ai-tool-could-crack-your-passwords-in-seconds/

![Time to crack a password](/00_includes/Networking_Images/time_to_crack.png)
*de tijd die een AI nodig heeft om een wachtwoord te kraken*

## Breaking the limits

Dit alles laat zien dat sterke wachtwoorden uit zowel lengte als complexiteit bestaan. 
En daar zit het probleem: mensen kunnen zulke wachtwoorden niet goed onthouden. Hierdoor gebruikt men veelal dezelfde wachtwoorden of simpele wachtwoorden en dat is zoals we hebben gezien niet veilig.

Er zijn echter goede oplossingen om wachtwoorden te vervangen, of aan te vullen.
**MFA** is hiervan een bekend voorbeeld: de extra stap die men moet doorlopen zou voor meer veiligheid moeten zorgen. Echter weten we dat oplossingen als een controle via een SMS-bericht te breken zijn.

Maar op dit moment is er een revolutie gaande om al dit op te lossen: de **passkeys**.
Passkeys zijn een oplossing waarbij men moet inloggen met een app via biometrie, pattern of PIN, maar dan op een veel geavanceerdere manier dan MFA. Hierbij wordt er namelijk gewerkt met PKI certification systeem waarbij de gebruiker inlogt op diens app en de app vervolgens inlogt op het systeem door middel van een digitaal certificaat.
Bij dit systeem is er dus geen sprake van een wachtwoord, maar een beveiligingslaag in de vorm van passkeys.

Dit alternatief wordt dan ook de toekomst: want dit is een betere beveiliging, en simpeler in het gebruik voor de user en de developers/systeembeheerders. En is in tegenstelling tot een wachtwoord niet te kraken door de standaard aanvallen.


