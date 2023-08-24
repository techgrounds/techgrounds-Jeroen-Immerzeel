# Ontwerp Documentatie
In dit document zullen alle diensten die er gebruikt gaan worden maar niet genoemd zijn in het ontwerpdocumentatie benoemd en omschreven worden.

# Resource Group
-De locatie van de resource group is Germany West Central.  

# Storage
- GRS wordt gebruikt met Read Access
- Bevat een storage Blob. 
- Blob access tier is "hot"
- Is type V2.
- Heeft RA-GRS redundancy
- Alleen private access, en heeft der halve een private link voor connectie welke valt onder de management vnet; hierbij wordt een private DNS zone gebruikt
- Soft delete wordt gebruikt voor Blobs, Containers en File shares
- Versioning voor Blobs wordt gebruikt inclusief change feed


# Vnets
- Voor betere beveiliging van de vnets moet er peering worden opgezet, dit zodat de management VM de webserver VM kan bereiken op het private IP in plaats van vanaf het internet.  
- Om de beveiliging te vergroten wordt de connectie van het webserver vnet naar het management vnet gesloten maar die van de management vnet naar het webserver vnet geopend. Zo kan de management server nooit vanuit de webserver bereikt worden bij een eventueel lek maar de webserver wel door de management server. 

# NSG
Beide subnets maken gebruik van een NSG met de volgende White Listing/deny rules:
1) De NSG op het management vnet krijgt de regel "only allow connections from <trusted IP>"
2) De NSG van de webserver vnet krijgt de regel "only allow connections from <trusted IP> for port 22"
3) De NSG van de webserver vnet krijgt de regel "only allow port 80"
 

# VMs 
- De management VM is een Windows 11 systeem; dit maakt connectie van RDP mogelijk en daarmee systeembeheer via een GUI. (in de test environment is dit een Linux server ivm licensing)
- De webserver VM is een Linux Ubuntu LTS 22-04 systeem. Dit maakt het gebruik van de Apache webserver mogelijk.
- De VMs krijgen eenieder andere login credentials.
- De VMs staan ieder in een andere availability zone; de webserver VM in AZ 1, de management VM in AZ 2.
- Alleen de ports die nodig zijn moeten bereikbaar zijn vanaf het internet
- De SSH/RDP ports moeten alleen bereikbaar zijn vanaf het management vnet en/of IP adres van de management VM. 
- Gezien het gebruik van SSH wordt er een key pair aangemaakt
- OS Disks zijn managed disks
- Public IP adressen en NICs worden bij verwijderen van VMs ook verwijderd
- De SKU voor de IP adressen is Standard; dit gezien deze availability zones ondersteund


# Overig
Er komt een Key vault met als regels:
- Purge protection aan: dit voorkomt het ongewild permanent verwijderen van de keys.
- Toegang tot de Key Vault gaat via RBAC.

# Access control
- Voor het gebruik van de key vault en toegang tot de keys wordt RBAC gebruikt. Hierbij wordt de manager de role van "owner" toegekend; andere accounts worden hoogstens de role van "Contributor" toegekend; deze worden niet aangemaakt.
- De credentials voor de servers **nog invullen**

_____

# Onderdelen die er gebouwd worden per versie
Ik zal het systeem bouwen in delen. Elk deel kent een eigen versie met als syntax ```V.0.groteversienummer.kleineversienummer```; bijvoorbeeld ```v.0.1.2```. Dit wordt bepaald door de regels die nodig zijn binnen de resources; bijvoorbeeld de private link naar het storage account, of de peering tussen de vnets. Regels die later kunnen worden toegevoegd, worden in latere versies toegevoegd.
Een grote versie heeft alle voorgestelde onderdelen voor deze versie zonder de benodigde regels; een kleine versie kent wel 1 of meerdere regels.  

# Versie v0.1
Deze versie zal bestaan uit een resource group, en een storage account.

## v0.1.1


# Versie v0.2
Deze versie voegt 2 vnets toe

# Versie v0.3
Deze versie voegt de 2 VMs toe

# Versie v0.4

# Versie v0.5

# Versie v0.6
Regels tussen de resources