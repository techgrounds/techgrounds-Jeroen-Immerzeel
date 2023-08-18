# NTW-07 Networking Case study

Het maken van een netwerkoplossing voor een klein e-commerce bedrijf.

## Key-terms
- Networking
- Network Architecture
- Network Diagram

# Opdracht

Deze opdracht vraagt om het maken van een netwerkdiagram met de volgende onderdelen:
- A web server where our webshop is hosted
- A database with login credentials for users on the webshop
- 5 workstations for the office workers
- A printer
- An AD server
- A file server containing internal documents


## Gebruikte bronnen
De in de opdracht gelinkte website "https://app.diagrams.net/"  
De informatie over DMZ gebruik op https://security.stackexchange.com/questions/58167/databases-in-dmz-and-intranet

## Ervaren problemen
Weinig. Het enige waar ik even over moest nadenken was of de database nu wel of niet in de DMZ thuishoort; dit heb ik opgezocht. 

# Uitwerking

# Het netwerk:

Het netwerk bestaat uit een client-server architectuur met een ster topologie.
Er zijn 3 servers: 1 AD server, 1 Fileserver en een backup-server. Er is een database met klantinformatie; ook deze wordt ge-back-üpt naar de back-up server.  
Daarnaast is er een DMZ waarin de webserver staat. 

# Het diagram:
![Het diagram](/00_includes/Networking_Images/diagram_assignment_7.png)


# Waarom deze oplossing?

Ik heb hierbij rekening gehouden met dat wat de learning coach stelde over de topologie; namelijk dat we uit moesten gaan van een LAN oplossing.

Ik heb daarom gekozen voor een oplossing waarbij de webserver in een Demilitarized Zone staat en alle andere onderdelen binnen een enkel LAN aanwezig zijn. Dit om zowel de security hoog te houden en de kosten laag. 

Er is sprake van een client-server network in een ster topologie met zowel Ethernet als WiFi.  
- Het WiFi netwerk is er primair voor de Wireless Printer, maar ook voor Ad Hoc connecties en heeft der halve zowel een intern netwerk als een guest network.

- Het wired network gebruikt een 24 ports switch. De fileserver in het netwerk heeft een backup server; deze backup server bevat ook de backups voor de database van de webserver.

Dit alles bij elkaar maakt voor een stevige basis waarbij zowel beveiliging als schaalbaarheid robuust zijn.