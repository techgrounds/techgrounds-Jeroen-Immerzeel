# Deliverables Exploration Epic


In het Exploration Epic worden de volgende deliverables gevraagd:

- Een puntsgewijze omschrijving van alle eisen
- Een puntsgewijs overzicht van alle aannames
- Een overzicht van alle diensten die gebruikt gaan worden.

Deze 3 deliverables staan hieronder:

# Deliverable 1:
*Een puntsgewijze omschrijving van alle eisen*

**De puntsgewijze omschrijving:**
- 1 subscription
- 1 resource group 
- 1 storage account met blob storage voor post deployment scripts 
- 2 vnets 
- 2 NSGs met regels om access naar VMs te reguleren
- 2 subnets; 1 per vnet 
- peering tussen vnets v
- 1 VM met webserver role 
- 1 VM voor management/admin 
- Een Key Vault voor de opslag van de SSH/RDP keys en andere keys 
- Een recovery vault voor de opslag van de back-ups
- Een database (optioneel) na aanleiding van een later verzoek


# Deliverable 2 

**Een puntsgewijs overzicht van alle aannames

Dit deel bevat alle aannames voor de onderdelen van het project.

**algemeen**  
- De eerste stap die genomen zal moeten worden voor de deployment is het opzetten van een resource group en daarna een key vault met secrets via de cli zodat de rest van de deployment van deze resources gebruik kunnen maken.


**Resource group**  
- De gehele resource group en alles daarbinnen wordt in de West Germany Central location geplaatst. Dit gezien deze location dichtbij is en alle onderdelen ondersteund

**Storage account** 
- Gebruik van redundancy is altijd nodig. Bij uitval van datacenter kan er dan toch nog een omgeving wordt deployed. Ik kies daarom voor GRS-RA als replication van de storage
- Soft delete en versioning is nodig om zo het onbruikbaar maken of verwijderen van de deployment scripts en andere data te voorkomen
- Er wordt een Blob, File en table storage gemaakt
- De blob storage is voor het opslaan van de ongestructureerde data
- File storage is nodig om de data tussen de administratie en webserver VMs te kunnen delen; dit is handig voor de administratie

**Vnets** en  **subnets**
 - Peering tussen de vnets is nodig gezien beide servers in een apart vnet staan en er een veilige connectie moet worden gemaakt
 - Deze verbinding tussen de vnets moet zo worden ingericht dat de connectie "one way" is; de webserver mag wel worden bereikt vanaf de management VM maar andersom niet


**Beveiliging servers**
Voor de beveiliging van de servers neem ik aan dat:
- Er gebruik gemaakt moet worden van in ieder geval NSG rules voor network access
- De webserver beheert zal worden via SSH; deze wordt een Linux server met custom data voor de deployment van de Apache webserver
- De management server kan alleen bereikt worden via NSG firewall regels of RBAC
- De encryptie voor de servers gaat via "Encryption at host"; dit versleuteld ook gelijk de backups gezien de voorliggende data van de backups al versleuteld is. 


- Voor de connectie met de management server wordt de NSG regel "allow source: my IP address" gebruikt
- De back-ups gaan dagelijks via de Azure backup policy en worden 7 dagen bewaart.

**Servers algemeen**
- De webserver wordt een Linux server. Dit maakt het opzetten een heel stuk simpeler door het gebruik van een custom script bij het aanmaken van de VM
- Er worden standard SKU Public IP adressen aangemaakt want alleen standard SKU kent ondersteuning voor availability zones
- De management server wordt een Windows server 22 datacenter edition VM. Dit om gemak van de GUI, SSH via powershell/cmd en login via RDP dus build-in voor meeste systemen thuis

**key vault**
- Er is een kans dat de keys voor login per ongeluk verwijderd worden. Hiervoor wordt de purge protection optie aangezet
- Alleen de admin mag toegang krijgen tot de vault. Deze heeft standaard als enige toegang.

**back-up**
- De back-ups worden 7 dagen bewaart; de snapshots 6. Dit gaat via een zelf aangemaakte policy.


# Deliverable 3
**Een overzicht van alle diensten die gebruikt gaan worden.**

Dit is een overzicht dat nog wordt aangevuld totdat het project klaar is; het is nog niet geheel duidelijk welke diensten er nu uiteindelijk allemaal gebruikt gaat worden.

1) Resource Group
2) Storage account met daarin
 - Blob Storage
 - File storage
 - Table storage
3) 2 Vnets
4) Network Peering
5) Network Security Group
6) 2 VMs
7) Key vault
8) Backup vault
9) Backup policy