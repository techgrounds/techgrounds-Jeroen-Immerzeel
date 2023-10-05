# Ontwerp Documentatie
In dit document zullen alle diensten die er gebruikt gaan worden maar niet genoemd zijn in het ontwerpdocumentatie benoemd en omschreven worden.

# Documentatie
- Voor de product owner wordt er een document met deployment informatie gemaakt; deze heet *deployment_information.md* en staat in de **Product_documentation/** folder

# Resource Group
- De locatie van de resource group is Germany West Central. 
- De resource group wordt via de CLI aangemaakt. 

# Storage
- GRS wordt gebruikt met Read Access
- Bevat een storage Blob en file storage.
- Blob access tier is "hot"
- Is type V2.
- Heeft RA-GRS redundancy
- Soft delete wordt gebruikt voor Blobs, Containers en File shares
- Versioning voor Blobs wordt gebruikt inclusief change feed


# Vnets
- Voor betere beveiliging van de vnets moet er peering worden opgezet, dit zodat de management VM de webserver VM kan bereiken op het private IP in plaats van vanaf het internet.  
- De servers kunnen alleen worden bereikt via of het IP adres van de administrator (administration VM) of via SSH (webserver VM) of via porten 80 en 443 (webserver webpage)

# NSG
Beide subnets maken gebruik van een NSG met de volgende White Listing/deny rules:
1) De NSG op het management vnet krijgt de regel "only allow connections from <trusted IP>"
2) De NSG van de webserver vnet krijgt de regel "only allow connections from <trusted IP> for port 22"
3) De NSG van de webserver vnet krijgt de regel "only allow port 80"
 

# VMs 
- De management VM is een Windows server 2022 Datacenter edition systeem; dit maakt connectie van RDP mogelijk en daarmee systeembeheer via een GUI. (in de test environment is dit een Linux server ivm licensing)
- De webserver VM is een Linux Ubuntu LTS 22-04 systeem. Dit maakt het gebruik van de Apache webserver mogelijk.
- De VMs krijgen eenieder andere login credentials die de gebruiker zelf kan bepalen.
- De VMs staan ieder in een andere availability zone; de webserver VM in AZ 1, de management VM in AZ 2.
- Alleen de ports die nodig zijn moeten bereikbaar zijn vanaf het internet
- De SSH/RDP ports moeten alleen bereikbaar zijn vanaf het management vnet en/of IP adres van de management VM. 
- Gezien het gebruik van SSH wordt er een key pair aangemaakt
- OS Disks zijn managed disks
- Public IP adressen en NICs worden bij verwijderen van VMs ook verwijderd
- De SKU voor de IP adressen is Standard; dit gezien deze availability zones ondersteund


# Key vault
Er komt een Key vault met als regels:
- Purge protection aan: dit voorkomt het ongewild permanent verwijderen van de keys.
- Deze wordt als eerste aangemaakt samen met de resource group en de key vault secrets; dit alles via de cli.


# Access control
- Voor de login op de VMs worden er tijdens de deployment de nodige usernames en passwords aangemaakt. Deze worden na aanmaken doorgevoerd in de deployment van de resources.
- Er zijn NSG regels die de toegang tot de administration server beperken tot het IP adres van de administrator.
  
_____
