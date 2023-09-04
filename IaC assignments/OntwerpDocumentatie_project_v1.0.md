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


# Key vault
Er komt een Key vault met als regels:
- Purge protection aan: dit voorkomt het ongewild permanent verwijderen van de keys.
- ~~~Toegang tot de Key Vault gaat via RBAC.~~~ Dit gaat niet met de beperkingen binnen de opdracht; de role die ik heb limiteert mijn autorisatie voor het aanmaken en beheren van acces. Dit is normaliter wel onderdeel van het maken van een systeem. 


# Access control
Voor de login op de VMs zijn de volgende access control regels va toepassing:
- Er wordt voor de webserver VM een key pair aangemaakt en de public key wordt als output gemaakt.
- Voor de management VM wordt een username/password combi gemaakt; de admin username is een output, de password een secure string en moet tijdelijk extern worden bewaard. Het password moet vervolgens na inloggen aangepast worden. Zie de volgende powershell script om dit het password aan te passen:

```
$SubID = "<SUBSCRIPTION ID>" 
$RgName = "production" 
$VmName = "managementVM" 
$Location = "GermanyWestCentral" 

Connect-AzAccount 
Select-AzSubscription -SubscriptionId $SubID 
Set-AzVMAccessExtension -ResourceGroupName $RgName -Location $Location -VMName $VmName -Credential (get-credential) -typeHandlerVersion "2.0" -Name VMAccessAgent
```
Om het subscription ID te achterhalen wordt de volgende opdracht ingegeven:

```
az account list --query "[].{subscription_id:id, name:name, isDefault:isDefault}" -o table
```

Hierna moet de remote access tot de VM worden gereset. Dit gaat via dit script:

```
Set-AzVMAccessExtension -ResourceGroupName "prod" -VMName "managementVM" -Name "aloise" -Location GermanyWestCentral -typeHandlerVersion "2.0" -ForceRerun $true
```

_____

# Post deployment scripts
onderzoeken

# Bicep visualizer