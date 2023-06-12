# NTW-01 OSI Stack

Het bestuderen van de OSI en TCP/IP modellen.

## Key-terms
- OSI model
- TCP/IP model
- 7 layers vs 4 layers
- Theory vs pratical implementation.

## Opdracht

### Gebruikte bronnen
Het boek CompTIA Network+ Study Guide boek dat ik al had voor mijn eerdere opleiding.
wikipedia voor algemene informatie en extra bronnen: https://en.wikipedia.org/wiki/OSI_model


### Ervaren problemen
Het gaat in deze opdracht om het lezen van informatie over de OSI en TCP/IP modellen, en had daarbij geen problemen. 

### Resultaat
*"Wat is het OSI model?"*

**OSI model In het kort:**  
Het OSI model is het door het OSI bedachte *"7 layer model"* voor het communiceren tussen verschillende computersystemen. Dit model is bedacht in de jaren '70 en '80, toen er nog geen standarisering was op dit vlak. Het kent 7 lagen: Physical, Datalink, Network, Transport, Session, Presentation en Application. Dit alles is in ISO/IEX 7498 en in de ITF x200 standaarden gedocumenteerd.

**De 7 lagen:**
Het OSI model kent 7 lagen met elk een eigen functie, protocollen en geboden services.

- *Layer 1*  
Dit is de physical layer en omvat het fysieke deel van het netwerk met daarin bekabeling, NICs, Hubs, USB connectiviteit en WiFi controllers en gebruikt hierbij electrische signalen, licht signalen en radiogolven. De primaire functie van deze laag is het doorsturen van de data over het medium.
Layer 1 heeft als *PDU* de **bit**.

- *Layer 2*
Dit is de DataLink layer en omvat Switches en Bridges en kent als belangrijkste protocollen Ethernet, Wifi (802.11) en ARP. De primaire functie van deze laag is het versturen van de data tussen individuele nodes; dit gaat via het MAC adres, oftewel het fysieke adres dat elk networkdevice heeft.
Layer 2 heeft als *PDU* het **frame**. 

- *Layer 3* 
Dit is de Network layer; de layer waar Routers op werken en kent als belangrijkste protocol het Internet Protocol, maar ook het ICMP protocol wat onder andere wordt gebruikt voor het "pingen" van nodes is een layer 3 protocol. De primaire functie is het routen van netwerkverkeer tussen verschillende netwerken. Dit rondsturen van packets tussen netwerken heet *Packet Switching*. 
Layer 3 heeft als *PDU* het **packet**.

- *Layer 4* 
Dit de Transport layer en kent als belangrijkste protollen TCP en UDP. De primaire functie van de laag is onder andere: segmenteren van de datastream, flow control, en het betrouwbaar (TCP) of snel(UDP) afleveren van de segments. 
Layer 4 heeft als *PDU* het *segment**

- *Layer 5*
Dit is de session layer. De primaire functie van deze laag is opbouwen, beheer en afbreken van de connectie tussen de 2 nodes op. 
Layer 5 heeft geen specifieke *PDU*.


- *Layer 6*
Dit is de Presentation layer. De primaire functie van deze is laag het vertalen, formateren en aanleveren van de data naar een bruikbare vorm voor de application layer of voor de receiving host. Hierbij handeld deze laag ook de encryptie en decryptie af.
Layer 6 heeft geen specifieke *PDU*.    

- *Layer 7* 
Dit is de Application layer. De primaire functie van deze laag is het mogelijk  maken van de communicatie tussen de eindgebruikers en de applicaties. Op layer 7 werken een groot deel van de netwerk protcollen waaronder:
- HTTP(S)voor browsing
- IMAP, POP, SMTP voor mail
- SSH, Telnet, RDP voor remote sessions
- NTP, DNS, DHCP, SMB voor basic functionality



**TCP/IP model in het kort**

Het TCP model, ook wel het **Internet Protocol suite**, is het model voor de abstractie van network functies dat in de praktijk gebruikt wordt en is vernoemd naar de belangrijkste protocollen: TCP/UDP en IP. Dit model wordt ook nog weleens het DoD model genoemd gezien het van origine vanuit het Amerikaanse Department of Defence afkomt.

Het TCP model kent 4 lagen welke grotendeels overlappen met verschillende OSI lagen.

*Layer 1*  
Dit is in het **tcp/ip model** de *Link Layer* en is vergelijkbaar met layers 1 en 2 van het OSI model. Deze kent der halve vergelijkbare fysieke onderdelen als Switches, Hubs, kabels en WiFi, en protocollen als ARP, Ethernet en WiFi(802.11.). Switching wordt binnen deze layer gefaciliteerd. 

*Layer 2*  
Dit is in het **tcp/ip model** de *Internet Layer* en is vergelijkbaar met layer 3 van het OSI model. Deze gebruikt het **IP** protocol. Routers zijn der halve een TCP/IP Layer 2 device. 


*Layer 3*  
Dit is in het **tcp/ip model** *Transport Layer* en is vergelijkbaar met layer 4 van het OSI model. TCP en UDP zijn hier de protocollen. Segmentation, flow control en het betrouwbaar(TCP) of snel (UDP) afleveren van de data stream zijn de belangrijkste functies.

*Layer 4*  
Dit is in het **tcp/ip model** de *Application Layer* en is vergelijkbaar met layer 5, 6 en 7 van het OSI model. Hierbinnen vallen alle protocollen voor process-to-process communicatie.

De overlapping van het OSI Model en het TCP/IP model is schematisch:

![De overlapping van de OSI en TCP/IP modellen](/00_includes/Networking_Images/OSI-vs-TCP-vs-Hybrid-2.png)


# NTW-0

## Key-terms

## Opdracht
### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
[Omschrijf hoe je weet dat je opdracht gelukt is (gebruik screenshots waar nodig).]