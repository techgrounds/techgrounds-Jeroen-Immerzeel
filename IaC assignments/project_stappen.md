# De stappen van het Project 

Dit zijn de stappen die nodig zijn om te komen tot het MVP:  
(De eerste stap is eigenlijk het aanmaken van een resource group. Dit kan binnen de Azure CLI, of in een template. Ik kies in deze om het nog te doen via een CLI commando; later zal ik dit inbouwen in de app. )  

De gehele app staat in het **Germany West Central** region.
De dev login info voor de app is:  
Username: developer   
Password: !pC11D3v@0kt

Stap 1)  
Het aanmaken van storage account met daarin een blob storage.

Stap 2) 
Het toevoegen van 2 vnets met elk de subnets die er gebruikt gaan worden.
-	IP adressen: 
-	10.10.0.0/16 en 10.20.0.0/16 voor vnets
-	10.10.10.10/24 voor webserv-vnet
-	10.20.20.20/24 voor management-vnet  

Stap 3)   
Het toevoegen van 2 NSGs(1 voor beide vnets) en de IP adressen.  
Namen van NSGs: “webserv-NSG” en “management-NSG”  
IPs:
-	IPv4
-	Standard SKU
-	Namen: “webserv-IP” en “management-IP”
-	IPs zone-redundant
-	Static
-	M$ network routing preference
-	Idle timeout standard, 4 minutes

Stap 4)   
Het toevoegen van de key vault.  
Het aanmaken van de secrets en deze opslaan in de keyvault is vanaf deze stap verplicht.  
-	Naam: “dev-app-vault” tijdens ontwikkeling, “prod-app-vault” voor productie
-	Soft delete aan; retention time 90 days (standard)
-	Purge protection enabled
-	Permission: Azure RBAC
-	Resource acces: allen aan
-	Public access: Selected Networks
-	<onbekend>


Stap 5)  
Het toevoegen van de 2 VMs.  
Hierbij is het van belang dat deze in aparte availability zones komen te staan. Ook moeten de VMs deze onderdelen bevatten:  
-	Type Standard B1s
-	Availability zones: management in 2 en webserver in 1
-	Public IP adressen: syntax is vm-<servername>-ip
-	OS: Linux Ubuntu Server 22.04 voor webserver (en dev) en Win 11 voor de management server
-	Namen: “VM-webserv” en “VM-mgmnt”
-	SSH en RDP login info; dit moet via de @secure decorator beveiligd worden ingevoerd
-	SSDs: standard SSDs (dit als advies)
-	Platform managed key
-	Deletion of IP/NIC na verwijderen VM uit
-	Geen load balancers
-	Alerts aan; basic alerts only
-	Custom data voor creatie Apache Webserver

Stap 6)  
Het aanmaken van de back-ups  
Is onduidelijk of dit via de VMs gaan of standalone.  

Stap 7)  
Het aanmaken van de netwerkregels:  
-	De network peering tussen de 2 Vnets
-	De beveiligde connectie tussen de management server en de webserver
-	De connectie tussen de 2 servers en het storage account (beveiligd?)

