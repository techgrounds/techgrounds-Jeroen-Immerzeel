# NTW-2 Network devices

## Key-terms
- Router
- Switch
- Hub
- Bridge
- DHCP
- DNS
- Modem

# Inhoud van de opdracht
- Benoem en beschrijf de functies van veel voorkomend netwerkapparatuur
- De meeste routers hebben een overzicht van alle verbonden apparaten, vind deze lijst. Welke andere informatie heeft de router over aangesloten apparatuur?
- Waar staat je DHCP server op jouw netwerk? Wat zijn de configuraties hiervan


### Gebruikte bronnen
Het boek CompTIA Network+ Study Guide Fifth Edition dat ik al had van een eerdere opleiding.  
Voor de afbeelding met netwerk apparaten:  
https://www.itrelease.com/2021/06/types-of-network-devices/


### Ervaren problemen
Eigenlijk geen. 
___
## *"1: Benoem en beschrijf de functies van veel voorkomende netwerkapparatuur."* 

**Modem**

Een **modem** is een layer 1 apparaat dat via modulatie van stroom of licht analoge en digitale signalen in elkaar overzet. "Modem" is een afkorting voor MOdulation DEmodulation.


**Switch**  
Een **switch** is een device met een x aantal netwerkpoorten waaraan nodes zijn verbonden.  Switches werken op de **Data Link layer** van het OSI model.   
Switches zitten tussen individuele hosts in, en sturen netwerkverkeer tussen deze hosts op een slimme manier.  
Hierbij wordt het **fysieke adres** oftewel het **MAC Adres** van de hosts voor gebruikt. De Switch gebruikt het **ARP** -protocol om het MAC Adres van de ontvanger op te vragen en stuurt de frame vervolgens door naar zijn bestemming. Een switch gebruikt vervolgens een CAM Table om MAC adressen aan netwerkpoorten te koppelen.  
Een Switch stuurt het inkomende verkeer altijd alleen door naar de juiste poort; dit in tegenstelling tot een hub. 
Een Switch deelt het netwerk in afzonderlijke **collision domains**. VLAN delen het netwerk op in individuele **broadcast domains** en werken ook via switches. 

**Hub**  
Een hub is vergelijkbaar met een Switch in dat deze een x aantal netwerkpoorten heeft en devices zo met elkaar verbindt. Echter stuurt een Hub het inkomende netwerkverkeer naar alle poorten. Deze facto is een Hub dan ook een "domme switch"; deze wordt dan ook niet meer gebruikt in moderne netwerken.   

**Bridge**  
Een **bridge** zit tussen 2 netwerkdelen in en verdeeld deze in 2 aparte collision domains. Deze zit op layer 2 van het OSI model en wordt ook wel vergeleken met een Switch qua functionaliteit op dit vlak.


**Router**  
Een **router** zit tussen netwerken in en zit op de Network layer van het OSI model. Een router gebruikt **IP adressen** om packets te routen. Voor routing decisions wordt een Routing Table gebruikt waarbij er aan elk IP adres in de Routing table een actie verbonden zit. Hierbij stuurt de router packets door naar de juiste port door het IP adres te controleren en deze te vergelijken met de Routing Table.
Een Router deelt netwerken op in afzonderlijke **broadcast domains**. 

**WiFi Router**
Een **WiFi Router** is het type router dat de meeste mensen thuis hebben. Dit is een router met WiFi-functionaliteit. Deze werkt dan ook op meerdere lagen van het OSI model: Layer 1 voor de NICs, Layer 2 voor de WiFi access point en Switching mogelijkheden, en Layer 3 voor de routing mogelijkheden.  
Het WiFi gedeelte van deze maakt het mogelijk om draadloos contact te maken met het netwerk. Voor de rest heeft deze veelal dezelfde functionaliteit als een normale router.

**WiFi AP**  
Een **WiFi Access Point** maakt het mogelijk om via Wifi (draadloos) contact te maken met een netwerk. Deze functioneert op layer 2 van het OSI model en is vergelijkbaar met een Hub: deze is dus "dom" en stuurt het inkomende signaal door naar alle aangesloten poorten/devices.  
Deze gebruikt radiogolven en is daarmee erg afhankelijk van de omstandigheden van de ruimte waarbinnen deze zich bevindt, én van welke generatie WiFi er gebruik gemaakt wordt.

Een AP kan ook functioneren als **Wireless Bridge** waarbij deze de ruimte tussen 2 of meerdere bedrade netwerkdelen draadloos overbrugd.

![Afbeelding met devices](/00_includes/Networking_Images/Types-of-network-devices.jpg)  
*Verschillende netwerk devices*  

___
## *2: De meeste routers hebben een overzicht van alle verbonden apparaten, vind deze lijst. Welke andere informatie heeft de router over aangesloten apparatuur?"* 

Ik heb zelf een Fritz Box WiFi router en deze geeft over de aangesloten apparaten de volgende informatie:
- De naam van het apparaat.
- De connectie medium (LAN, Wifi)
- Het interne IP adres.
- De properties (Type WiFi connectie, snelheid)

![Aangesloten apparatuur](/00_includes/Networking_Images/Aangesloten_apparatuur.png)
___
## *3: Waar staat je DHCP server op jouw netwerk? Wat zijn de configuraties hiervan"*
In mijn netwerk heeft de **WiFi Router** ook de DCHP-functie. Deze geeft als opties:  
- De IP range opties; dit zijn de IP adressen die er uitgedeeld mogen worden.
- De duur van de lease van een IP adres.
- Het adres van de lokale DNS server. 

![Screenshot van de DHCP](/00_includes/Networking_Images/DHCP_Fritz.png)