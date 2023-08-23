# Ontwerp Documentatie
In dit document zullen alle diensten die er gebruikt gaan worden maar die niet in het ontwerp staan worden benoemd en omschreven.

# Resource Group
De locatie van de resource group is Germany West Central.  

# Storage
GRS wordt gebruikt met Read Access
Blob access tier is "hot"
public access uit, private only en dus wordt er een private endpoint gebruikt.
Soft delete options staan aan
Versioning en change feed for Blobs staan aan


# Vnets
Voor betere beveiliging van de vnets moet er een peering worden opgezet, dit zodat de management VM de webserver VM kan bereiken op het private IP in plaats van vanaf het internet.  

# NSG
Beide subnets maken gebruik van een NSG met de volgende White Listing/deny rules:
1) De NSG op het management vnet krijgt de regel "only allow connections from <trusted IP>"
2) De NSG van de webserver vnet krijgt de regel "only allow connections from <trusted IP> for port 22"
3) De NSG van de webserver vnet krijgt de regel "only allow port 80"
 

# VMs 
De management VM is een Windows 11 systeem; dit maakt connectie van RDP mogelijk en daarmee systeembeheer via een GUI. (in de test environment is dit een Linux server ivm licensing)
De webserver VM is een Linux Ubuntu LTS 22-04 systeem. Dit maakt het gebruik van de Apache webserver mogelijk.
De VMs krijgen eenieder andere login credentials.
De VMs staan ieder in een andere availability zone; de webserver VM in AZ 1, de management VM in AZ 2.

# Overig
Er komt een Key vault met als regels:
Purge protection aan: dit voorkomt het ongewild permanent verwijderen van de keys.
Toegang tot de Key Vault gaat via RBAC.

Er komen back-ups:
Dagelijks 3 back-ups met retention van 7 dagen

