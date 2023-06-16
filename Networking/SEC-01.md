# SEC-01 Network Detection

# Key-terms
- nmap
- Wireshark

# Opdracht

De opdracht vraag het volgende:
- Scan the network of your Linux machine using nmap. What do you find?
- Open Wireshark in Windows/MacOS Machine. Analyse what happens when you open an internet browser. (Tip: you will find that Zoom is constantly sending packets over the network. You can either turn off Zoom for a minute, or look for the packets sent by the browser between the packets sent by Zoom.)


# Gebruikte bronnen
- De website https://nmap.org/book/man.html voor hulp bij het gebruikt van NMAP
- Deze tutorial van NetworkChuck op YouTube: https://www.youtube.com/watch?v=4t4kBkMsDbQ&t

# Ervaren problemen
Door een druk netwerk was vraag 2 wat moeilijk te beantwoorden.
# Resultaat

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

Als er op het 3.121.130.219/24 netwerk een -sP scan wordt uitgevoerd worden er 49 hosts ontdekt.
![-sP scan results](/00_includes/Networking_Images/nmap__sP.png) 

Als er op het 3.121.130.219/24 netwerk een -sT scan wordt uitgevoerd duurt de scan wat langer, maar geeft deze wel meer informatie; van elke host wordt dan ook direct bekend welke poorten er open staan.

Als we de resultaten van de -sS en -sT scans vergelijken zien we dat ze beiden bijna dezelfde informatie geven, maar niet alles is hetzelfde. Daarom is het bij netwerkscanning nodig om meerdere scans uit te voeren. 

![-sT scan resultaten](/00_includes/Networking_Images/nmap_sT_result.png)
*sT met 988 closed ports*

![-sS scan resultaten](/00_includes/Networking_Images/nmap_sS_result.png)
*sS met 990 closed ports*


Met -sV kan er gecontroleerd worden welke protocollen er actief zijn en het versienummer van deze. Dit kan handig zijn om zwakke plekken in een netwerk te ontdekken.

Met het -O argument zal nmap uitzoeken welk operating system een systeem gebruikt. Hierbij kan deze een "guess" doen waarbij er een percentuele kans wordt aangegeven.

Met -A zal namp alle bovenstaande scans combineren én een tracerout doen. Dit is de meest uitgebreide scan, die ook het meeste tijd kost.

![-A scan resultaat](/00_includes/Networking_Images/nmap_A.png)







*"2: Open Wireshark in Windows/MacOS Machine. Analyse what happens when you open an internet browser."*

 Deze vraag was voor mij wat moeilijk om te beantwoorden met afbeeldingen doordat mijn netwerk druk is, maar kan deze vraag makkelijk beantwoorden in tekst.

 Als er een website geladen wordt, net als bij het openen van een browser, worden er achtereenvolgens deze stappen doorlopen:
 
 - Bij een nog onbekende host wordt er eerst een DNS request gedaan om de URL of het FQDN te vertalen naar een IP adres.  
 - Als het IP adres van de host bekend is wordt er naar het bijbehorende IP adres een HTTP GET request verstuurd om het HTML document waaruit de website bestaat op te vragen. 
 - De host zal, als deze actief is, een HTTP status geven en het HTML document versturen.
 - De browser zal hierna de HTML pagina renderen naar een bruikbare webpagina.

 Als er sprake is van een nieuw netwerk wordt er voordat er een DNS verzoek wordt verstuurd ook nog een ARP request verstuurd voorr de gateway van het netwerk. Dit om zo het MAC adres van de gateway te verkrijgen. Deze is nodig omdat elk internetwerkverkeer van router naar router wordt doorgestuurd; een eventuele DNS en/of HTTP request zal dus eerst naar de router worden verstuurd, welke deze vervolgens doorstuurd naar de volgende router op de route naar de betrokken servers.