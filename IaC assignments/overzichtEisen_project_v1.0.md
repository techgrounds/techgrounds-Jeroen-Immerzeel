# Deliverable 1:
*Een puntsgewijze omschrijving van alle eisen*

Er worden in het project document een aantal eisen gesteld aan het te maken systeem. 
Dit document vat deze eisen samen in zowel een korte, puntsgewijze samenvatting, als een uitgebreidere samenvatting.
De onderdelen die niet worden vermeld in deze omschrijving maar die wel nodig zijn voor het systeem staan beschreven in het document **OntwerpDocumentatie_project_v1.0** waarvoor de aannames en beslissingen beschreven staan in het document **overzichtAannames_project_v1.0**. 


# In het kort:
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

# Een uitgebreide beschrijving van alle bekende eisen: 

### Storage account
- Opslaglocatie voor de PostDeploymentScripts
- Bevat een storage Blob. 

### Vnets: 
- 2 vnets
- Elk vnet kent een eigen subnet 
- 1 voor de productieomgeving met daarin een Webserver in availability zone 2 en een NSG 
- 1 voor de management layer met daarin een managementserver in availability zone 1 en een NSG  


### IP adressen
- Er zijn 2 public IP addresses nodig: voor elke server 1. Deze wordt bij het aanmaken van de VM gespecificeerd
- Er zijn 2 subnets met de private IP ranges: ```10.10.10.0/24``` en ```10.20.20.0/24```

### 2 subnets
- Beide servers moeten in hun eigen subnet staan. De te gebruiken subnets zijn ```10.10.10.0/24``` en ```10.20.20.0/24```  
- Deze moeten via een NSG/Firewall beschermd worden

### Management server  
- Deze moet in de management vnet staan 
- Moet in availability zone 1 staan. 
- Deze mag alleen bereikbaar zijn vanaf vertrouwde locaties zoals het systeem van de manager thuis. Dit gaat via NSG inbound rule "allow my IP"
- Is de enige locatie waar vanaf de web server beheert mag worden  
- Moet een public en private IP hebben


### Web Server VM
- Moet in het productie vnet staan
- Moet in availability zone 2 staan.
- De web server role moet via een script automatisch geïnstalleerd worden; dit gaat via een script met custom data.
- De web server moet vanaf het internet bereikbaar zijn; heeft dus een public en private IP nodig.


### Encryptie  
- De data in rest op de VM disks moet worden encrypted

### Back-up
- Er moeten dagelijks back-ups worden gemaakt. Deze moeten na 7 dagen worden verwijderd. 

### NSGs
- Er moet voor elk subnet een NSG komen. Deze moet de toegang tot de servers instellen via trusted IPs 
- De connectie tussen de thuis locatie van de manager en de management server moet beveiligd zijn
- Toegang tot de Web server over SSH/RDP mag alleen vanaf management server/VPN

### Key vault
- Er moet een key vault aangemaakt worden voor de opslag van de keys



