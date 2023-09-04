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
- 2 NSGs met regels om access naar VMs te regulerenv 
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



**Resource group**  
- De gehele resource group en alles daarbinnen wordt in de West Germany Central location geplaatst. Dit gezien deze location dichtbij is en alle onderdelen ondersteund

**Storage account** 
- Gebruik van redundancy is altijd nodig. Bij uitval van datacenter kan er dan toch nog een omgeving wordt gedeployt. Ik kies daarom voor GRS als replication van de storage
- Er is geen public access tot de storage en dus wordt er gebruik gemaakt van een private link
- Soft delete en versioning is nodig om zo het onbruikbaar maken of verwijderen van de deployment scripts en andere data te voorkomen

**Vnets** en  **subnets**
 - Peering tussen de vnets is nodig gezien beide servers in een apart vnet staan en er een veilige connectie moet worden gemaakt
 - Deze verbinding tussen de vnets moet zo worden ingericht dat de connectie "one way" is; de webserver mag wel worden bereikt vanaf de management VM maar andersom niet


**Beveiliging servers**
Voor de beveiliging van de servers neem ik aan dat:
- Er gebruik gemaakt moet worden van in ieder geval NSG rules
- De webserver beheert zal worden via SSH of RDP (eisen OS nog onduidelijk)
- De management server kan alleen bereikt worden via NSG firewall regels of RBAC
- De encryptie voor de servers gaat via de optie *platform managed key*; dit is de meest simpele manier, maar heeft toch wat setup nodig (zie https://learn.microsoft.com/en-us/azure/virtual-machines/disks-enable-host-based-encryption-portal?tabs=azure-powershell#prerequisites)
- De optie *NIC network security group* op *none* gaat gezien deze al via NSGs worden beheerd

- Voor de connectie met de management server wordt de NSG regel "allow source: my IP address" gebruikt
- De back-ups gaan via Azure en worden 7 dagen bewaart. Er wordt elke dag een snapshot gemaakt en elke 7e dag wordt er een volledige back-up gemaakt


**Servers algemeen**
- De webserver wordt een Linux server. Dit maakt het opzetten een heel stuk simpeler door het gebruik van een custom script bij het aanmaken van de VM
- Er worden standard SKU Public IP adressen aangemaakt want alleen standard SKU kent ondersteuning voor availability zones
- De management server wordt een Windows 11 VM. Dit om gemak van de GUI, SSH via powershell/cmd en login via RDP dus build-in voor meeste systemen thuis

**key vault**
- Er is een kans dat de keys voor login per ongeluk verwijderd worden. Hiervoor wordt de purge protection optie aangezet
- Alleen de admin mag toegang krijgen tot de vault. Hiervoor wordt Azure RBAC gebruikt; de admin de owner-role

**back-up**
- De back-ups worden 7 dagen bewaart; de snapshots 6. Dit gaat via een zelf aangemaakte regel.


# Deliverable 3
**Een overzicht van alle diensten die gebruikt gaan worden.**

Dit is een overzicht dat nog wordt aangevuld totdat het project klaar is; het is nog niet geheel duidelijk welke diensten er nu uiteindelijk allemaal gebruikt gaat worden.

1) Resource Group
2) Storage account met daarin een Blob Storage
3) 2 Vnets
4) Network Security Groups
5) 2 VMs
6) Key vault
7) Backup vault
8) Network Peering
9) 