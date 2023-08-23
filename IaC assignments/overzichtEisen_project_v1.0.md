# Deliverable 1:
*Een puntsgewijze omschrijving van alle eisen*

Het basis ontwerp zal bestaan uit:
In het kort:

- Location is West Germany
- 1 subscription
- Een Key Vault voor de opslag van de SSH/RDP keys en andere keys
- Een recovery vault voor de opslag van de back-ups
- 2 vnets met peering
- 2 VMs elk in een ander availability zone (daarom location)
- Storage account met blob storage
- 2 NSGs

Uitgebreid: 

### Storage account
- Opslaglocatie voor de PostDeploymentScripts
- Is type V2.
- Heeft RA-GRS redundancy
- Bevat een storage Blob. 
- Heeft een private link voor connectie welke valt onder de management vnet; hierbij wordt een private DNS zone gebruikt
- Soft delete wordt gebruikt voor Blobs, Containers en File shares
- Versioning voor Blobs wordt gebruikt inclusief change feed

### Vnets: 
- 2 vnets
- Elk vnet kent een eigen subnet 
- 1 voor de productieomgeving met daarin een Webserver in availability zone 2 en een NSG 
- 1 voor de management layer met daarin een managementserver in availability zone 1 en een NSG  
- Beide Vnets moeten gepeered worden


### IP adressen
- Er zijn 2 public IP addresses nodig: voor elke server 1. Deze wordt bij het aanmaken van de VM gespecificeerd
- Er zijn 2 subnets met de private IP ranges: ```10.10.10.0/24``` en ```10.20.20.0/24```

### 2 subnets
- Beide servers moeten in hun eigen subnet staan. De te gebruiken subnets zijn ```10.10.10.0/24``` en ```10.20.20.0/24```  
- Deze moeten via een NSG/Firewall beschermd worden
- Servers moeten hierdoor zowel een public als een private IP kennen


### Management server  
- Deze moet in de management Vnet staan 
- Moet in availability zone 1 staan. 
- Deze mag alleen bereikbaar zijn vanaf vertrouwde locaties zoals het systeem van de manager thuis. Dit gaat via NSG inbound rule "allow my IP"
- Is de enige locatie waar vanaf de Web server beheert mag worden  
- Moet een public en private IP hebben
- Windows server 2022.  


### Web Server VM
- Moet in het productie Vnet staan
- Is een Linux server
- Moet in availability zone 2 staan.
- De web server role moet via een script automatisch geïnstalleerd worden; dit gaat via een script met custom data.
- Web server moet vanaf het internet bereikbaar zijn; heeft dus een public en private IP nodig.
- Alleen de ports die nodig zijn voor de webserver moeten bereikbaar zijn vanaf het internet; de SSH/RDP ports moeten alleen bereikbaar zijn vanaf het management vnet en/of IP adres van de management VM. 
- Gezien het gebruik van SSH wordt er een key pair aangemaakt; de username ```manager``` is en keypair name ```webserv-key``` is, en de SSH port 22 open staat

### Server  opties algemeen
- Disks zijn managed disks
- Public IP adressen en NICs worden bij verwijderen van VMs ook verwijderd
- De SKU voor de IP adressen is Standard; dit gezien deze availability zones ondersteund



### Encryptie  
- De data in rest op de VM disks moet worden encrypted

### Back-up
- Er moeten dagelijks back-ups worden gemaakt. Deze moeten na 7 dagen worden verwijderd. 

### NSGs
- Er moet voor elk subnet een NSG komen. Deze moet de toegang tot de servers instellen via trusted IPs 
- De connectie tussen manager thuis en de management server gaat via de regel "allow connection via <IP>"
- Toegang tot SSH/RDP (ports 22 en 3389) van Web server alleen vanaf management server/VPN

### Key vault
-Er moet een key vault aangemaakt worden voor de opslag van de keys.
- Hierbij worden RBAC, Soft delete en purge protection gebruikt.
- De connectie gaat via een private endpoint


### RBAC
- Voor het gebruik van de key vault en toegang tot de keys wordt RBAC gebruikt. Hierbij wordt de manager de role van "owner" toegekend; andere accounts worden hoogstens de role van "Contributor" toegekend; deze worden niet aangemaakt.

