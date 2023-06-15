# NTW-03 Protocols


## Key-terms
- Protocols
- Wireshark 
- IANA
- OSI Layers
# Opdracht

Deze opdracht gaat over de vraag welke protocollen er op welke OSI layer zijn en hoe wireshark werkt.  
Deze opdracht kent 3 deelopdrachten:
- Identify several other protocols and their associated OSI layer. Name at least one for each layer.
- Figure out who determines what protocols we use and what is needed to introduce your own protocol.
- Look into wireshark and install this program. Try and capture a bit of your own network data. Search for a protocol you know and try to understand how it functions.

## Gebruikte bronnen
- https://www.wireshark.org website en hun /faq pagina. Dit voor zowel het downloaden van wireshark als de informatie die nodig was om een probleem op te lossen.
- https://www.nos.nl en http://info.cern.ch voor de voorbeelden van de wireshark opdracht.
- https://en.wikipedia.org/wiki/List_of_network_protocols_(OSI_model) voor de verschillende protocollen  
- Daarnaast mijn al bestaande kennis en het boek *CompTIA Network+ a study guide, fifth edition*.

## Ervaren problemen
1: wireshak gaf een foutmelding over "promiscuous mode" die ik heb kunnen oplossen met het doorlezen van de faq op https://wireshark.org/faq   

<br>


# Uitwerking

# *"1: Identify several other protocols and their associated OSI layer. Name at least one for each layer."*

**Layer 1**  
Dit is de physical layer en kent protocollen voor het versturen van de bits. De meest bekende hiervan zijn de fysieke implementaties van Ethernet zoals 1000BASE-T voor Gigabit Ethernet die we thuis veelal gebruiken.

**Layer 2**  
Dit is de DataLink Layer en kent als bekenste 2 protocollen **Ethernet** en **WiFi**. 

**Layer 3**  
Dit is de Network Layer en heeft als meest bekende en belangrijkste protocol het **Internet Protocol**. Er worden nu 2 versies van dit protocol gebruikt: *IP4*  en *IPv6*.  

Omdat we een tekort hebben aan IP4 adressen is IPv6 ontwikkeld en het is de bedoeling dat we de komende jaren overgaan naar een veelal IPv6 internet.   
Daar waar IP4 een 32 bits adres is en daarmee slechts *4,294,967,296* adressen kent, heeft IPv6 een 128 bit adres en dus *340 miljard miljard miljard* adressen; of om dit meer wiskundig te stellen heeft IP4 2^32 en IPv6 2^128 adressen.  

**Layer 4**  
Dit is de Transport Layer en kent 2 zeer belangrijke protocollen: **TCP** en **UDP**.
- **TCP** wordt gebruikt voor het segmenteren en betrouwbaar versturen van deze segmenten.
- **UDP** wordt gebruikt voor het versuren van datagrammen waarbij tijdige aflevering van groter belang is dan betrouwbaarheid.

TCP wordt dan ook gebruikt voor het versturen van data die accuraat moet zijn waar UDP vooral gebruikt wordt voor data die snel geleverd moet worden; denk hierbij aan downloads bij TCP en streamingdiensten bij UDP.

**Layer 5**  
Dit is de session layer en kent door diens functie signalling protocollen voor het beheer van sessions, zoals de tunneling protocollen L2TP en L2F welke gebruikt worden voor VPNs.  


**Layer 6**  
Dit is de presentation layer, gezien deze laag de encryptie afhandeld kent deze de SSL en TLS protocollen als belangrijke protocollen.

**Layer 7**

Dit is de application layer en kent een groot aantal protocollen; een aantal bekende voorbeelden zinn:
- **POP**, **IMAP** en **SMTP** voor email services.
- **HTTP**, **HTTPS** voor het versturen van hypertext documenten; browsen op het web.
- **BootP**, **DHCP** voor het instellen van dynamic IP information.
- **DNS** voor het omzetten van IP adres naar url en vice versa.
- **SSH**, **Telnet**, **RDP** voor remote sessions
- **FTP**, **SFTP**, **TFP** voor remote file sharing  



# *"2: Figure out who determines what protocols we use and what is needed to introduce your own protocol."*
Het IANA, of Internet Assigned Numbers Association beheert de regels betreffende de protocollen hun port nummers. Hierbij worden 3 verschillende groepen poorten gebruikt:
- Poorten 0-1023 worden *"well known ports"* genoemd en hebben een officieel geassocieerd protocol. 
- Poorten 1024 tot 49151 zijn *"registered ports"* en hebben ook een geassocieerd protocol; deze kunnen officieel door het IANA zijn erkent, of onofficieel zijn maar wel gestandaardizeerd voor dat gebruik zijn.  
- Poorten met poortnummers tussen de 49152 en 655535 zijn *"emphemeral ports"* en mogen door elk programma gebruikt worden; deze worden o.a. voor **Port Address Translation** gebruikt.  

Voor het registreren van het gebruik voor ports is een specifieke procedure waarbij er een "Request for Change" moet worden ingediend bij het IANA waarna er na een inspraak procedure toestemming kan komen om deze port te gebruiken.   
Een application layer protocol dat gedragen wordt over TCP kan men zo zelf maken; het enige wat dan nodig is is een specificatie van commando's en payloads die gedragen worden over TCP.

   

# *"3: Look into wireshark and install this program. Try and capture a bit of your own network data. Search for a protocol you know and try to understand how it functions.* 

Wireshark is een programma dat netwerkverkeer bit by bit vangt en van deze data een overzicht maakt.
Als een connectie niet beveiligd is met HTTPS TLS/SSL kan men met dit programma het gehele data stream volgen en uitlezen, daar waar de versleuteling met TLS/SSL voor HTTPS de data stream onleesbaar maakt.

Het opvangen van netwerk data gaat in een aantal simpele stappen:
- Kies de NIC welke je wilt afluisteren.
- Om een connectie te filteren gebruik de filter box. 

In mijn geval heb ik mijn Ethernet 2 connectie en TCP geselecteerd en ben ik naar 2 sites gesurfed: https://nos.nl/ en http://info.cern.ch . De eerste site is beveiligd met TLS/SSL versleuteling, de tweede is zonder enige versleuteling. (De tweede site is overigens de eerste website ooit gemaakt.)

Daar waar de data stream van en naar de eerste site alleen uit wat willekeurige tekens bestaat en daarmee totaal onleesbaar is, is de data stream van de tweede site geheel leesbaar.

![De versleutelde data van en naar de nos.nl website](/00_includes/Networking_Images/https_stream.png)
*onleesbare data stream* 

![De onversleutelde data van en naar de cern.ch website](/00_includes/Networking_Images/http_stream.png)  
*geheel leesbare data stream*

De TCP informatie die wireshark geeft bestaat uit alle onderdelen in de TCP header. 
De belangrijkste onderdelen van een TCP header zijn:
- Source en destination ports
- Segment length
- Sequence en acknowledgement numbers
- Flags (deze bepalen de inhoud van het segment)

De sequence en acknowledgement numbers worden gebruikt om aan te geven in welke volgorde de segmenten moeten worden heropgebouwd. 

De segment length geeft aan hoe groot het segment is. 

De flags bestaan uit 12 bits welke een aantal meldingen over de inhoud van het TCP segment geven. Ook geven deze de *"three way handshake"* die TCP gebruikt weer. Deze "handshake" bestaat uit:
- Syn --> synchronisatie verzoek tussen client en server vanuit de client
- Syn Ack --> acknowledgment van het synchronisatie verzoek vanuit de server 
- Ack -> acknowledgement van de syn ack vanuit de client

Als de client of server de connectie wilt beëindigen vindt er een * "4 way handshake"* plaats:
- Fin --> verzoek tot sluiten van connectie vanuit client
- Fin Ack --> goedkeuren van het sluiten vanuit de server
- Fin --> verzoek tot sluiten van de connectie vanuit de server
- Fin Ack --> goedkeuren van het sluiten vanuit de client

![Een TCP ack segment](/00_includes/Networking_Images/tcp_wireshark.png)
*De inhoud van van een TCP header*


Een klein weetje: bij een port scanner als NMAP, welke gebruikt wordt voor network enumeration, kan een onvolledige TCP handshake gebruikt omdat dit sneller is. Dit wordt ook wel een SYN scan genoemd. Daarom is het uitlezen van netwerk verkeer op onvolledige TCP handshakes onderdeel van menig onderzoek en wordt bijna altijd automatisch gedetecteerd door een Intrusion Detection System. 