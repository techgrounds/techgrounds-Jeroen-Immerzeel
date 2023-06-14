# NTW-07 Networking Case study

Het maken van een netwerkoplossing voor een klein e-commerce bedrijf.

## Key-terms
- Networking
- Diagram

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

## Ervaren problemen


# Uitwerking

# Het diagram:
![Het diagram](/00_includes/Networking_Images/diagram_assignment_7.png)

# Waarom deze oplossing?

Ik heb hierbij rekening gehouden met het geen wat de learning coach stelde; namelijk dat we uit moesten gaan van een LAN oplossing.

Ik heb daarom gekozen voor een oplossing waarbij de webserver en primaire klanten database in een Demilitarized Zone staan en alle andere onderdelen binnen een enkel LAN aanwezig zijn. Dit om zowel de security hoog te houden en de kosten laag. 

Er is sprake van een wired en wireless network:  
- Het wireless netwerk is er primair voor de Wireless Printer, maar ook voor Ad Hoc connecties en heeft der halve zowel een intern netwerk een guest network.

- Het wired network heeft een ster topologie met als hart een 24 ports switch. De fileserver in het netwerk heeft een backup server; deze backup server bevat ook de backups voor de database van de webserver.

Dit alles bij elkaar maakt voor een stevige basis waarbij zowel beveiliging als schaalbaarheid robuust zijn.