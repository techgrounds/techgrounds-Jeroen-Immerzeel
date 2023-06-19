# SEC-01 Network Detection

# Key-terms
- nmap
- Wireshark

# Opdracht

De opdracht vraag het volgende:
- Scan the network of your Linux machine using nmap. What do you find?
- Open Wireshark in Windows/MacOS Machine. Analyse what happens when you open an internet browser. 

# Gebruikte bronnen
- De website https://nmap.org/book/man.html voor hulp bij het gebruikt van NMAP
- Deze tutorial van NetworkChuck op YouTube: https://www.youtube.com/watch?v=4t4kBkMsDbQ&t

# Ervaren problemen
Door een druk netwerk was vraag 2 wat moeilijk te beantwoorden.
# Resultaat

# NMAP
*"1: Scan the network of your Linux machine using nmap. What do you find?"*     
Nmap moet eerst worden geinstalleerd; dit gaat via **sudo apt install nmap -y**.
Om met nmap het netwerk te scannen kan je nmap [IP ADRES] opgeven als commando.

Nmap kan op veel verschillende manieren scans uitvoeren. Een aantal voorbeelden zijn:

- -sT > full TCP connect scan
- -sS > TCP SYN only scan (wordt ook wel "stealth scan" genoemd)
- -sP  > ping scan.
- -sV > protocol version detection
- -O > OS detection
- --traceroute
- -A > een combinatie scan met -sS, -sV, -O en --traceroute

Als er op het 3.121.130.219/24 netwerk een -sP scan wordt uitgevoerd worden er 49 hosts ontdekt. -sP geeft een overzicht met IP adres, of de Host actief is en wat de latency is.

![-sP scan results](/00_includes/Networking_Images/nmap__sP.png) 
*Resultaat van een -sP scan* 

Als er op het 3.121.130.219/24 netwerk een -sT scan wordt uitgevoerd duurt de scan wat langer, maar geeft deze wel meer informatie; van elke host wordt dan ook direct bekend welke poorten er open staan.

Een -sS scan heeft bijna dezelfde werking en resultaten als een -sT scan, maar breekt de TCP voortijdig af. Dit maakt de scan in theorie sneller, en minder detecteerbaar door een IDS/IPS.

Als we de resultaten van de -sS en -sT scans vergelijken zien we dat ze beiden bijna dezelfde informatie geven, maar niet alles is hetzelfde. Daarom is het bij netwerkscanning/emuniration nodig om meerdere scans uit te voeren. 

![-sT scan resultaten](/00_includes/Networking_Images/nmap_sT_result.png)
*sT met 988 closed ports*

![-sS scan resultaten](/00_includes/Networking_Images/nmap_sS_result.png)
*sS met 990 closed ports*


Met -sV kan er gecontroleerd worden welke protocollen er actief zijn en het versienummer van deze. Dit kan handig zijn om zwakke plekken in een netwerk te ontdekken.

Met het -O argument zal nmap uitzoeken welk operating system een systeem gebruikt. Hierbij kan deze een "guess" doen waarbij er een percentuele kans wordt aangegeven.

Met -A zal namp alle bovenstaande scans combineren én een traceroute maken. Dit is de meest uitgebreide scan, die ook het meeste tijd kost.

![-A scan resultaat](/00_includes/Networking_Images/nmap_A.png)




# Wireshark


*"2: Open Wireshark in Windows/MacOS Machine. Analyse what happens when you open an internet browser."*

 Deze vraag was voor mij wat moeilijk om te beantwoorden met afbeeldingen doordat mijn netwerk druk is, en doe het dan ook alleen in tekst.

 Wireshark laat alle data zien dat verstuurd wordt over een medium. Hierbij deelt deze de data in op welke inhoud deze heeft: protocollen, de grootte in bits, source en destination en meer.

 Als er een website geladen wordt, net als bij het openen van een browser, worden er opp net netwerk achtereenvolgens deze stappen doorlopen:
 
 - Bij een nog onbekende host wordt er eerst een DNS request gedaan om de URL of het FQDN te vertalen naar een IP adres. Dit geeft een DNS request frame in Wireshark.
 - Als het IP adres van de host bekend is wordt er naar het bijbehorende IP adres een HTTP GET request verstuurd om het HTML document waaruit de website bestaat op te vragen. Dit geeft een HTTP GET frame in Wireshark.
 - De host zal, als deze actief is, een HTTP status geven en het HTML document versturen.
 - De browser zal hierna de HTML pagina renderen naar een bruikbare webpagina.

 Als er sprake is van een nieuw netwerk wordt er voordat er een DNS verzoek wordt verstuurd ook nog een ARP request verstuurd voor de gateway van het netwerk. Dit om zo het MAC adres van de gateway te verkrijgen. Deze is nodig omdat elk internetwerkverkeer van router naar router wordt doorgestuurd; een eventuele DNS en/of HTTP request zal dus eerst naar de router worden verstuurd, welke deze vervolgens doorstuurd naar de volgende router op de route naar de betrokken servers. Ook deze ARP frames worden getoond in Wireshark.

 