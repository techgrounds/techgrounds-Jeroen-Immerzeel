# IaC notes
Dit zijn notities voor de IaC opdracht.
Unknowns worden nog gevraagd aan Product Owner 
Budget is €50 voor bouw, niet voor gebruik.

## Sprintreviews zijn op 1 en 15 september
Bij de eerste review moet er al een werkend deel opgeleverd zijn.
De actiepunten die tijdens de reviews naar bovenkomen zijn de User Stories voor de volgende sprint
Tijdens elke sprint wordt er een presentatie gehouden over het systeem, de voortgang en het gedane werk en werkzaamheden (al dan niet die er nog moeten worden gedaan)

## Documentatie
### Ontwerpdocumentatie:
Bevat de **werking** **instellingen** **argumenten** en **rechten** die nodig zijn voor de deployment. 
Ook de NSG regels, visualisatie van en in welke volgorde de deployment wordt gedaan.

### Beslissingsdocumentatie
Dit bevat de keuzes en afwegingen die er gemaakt worden, waaronder over:
- de gebruikte diensten
- assumpties
- verbeteringen aan het systeem

# User Stories:
## Epic Exploration
De devilerables voor de epic Exploration zijn:
[x] Opsommen van vragen
[x] Opsomming van aannames na aanleiding van niet beantwoorde vragen.
[] Opsomming van diensten die wel nodig zijn maar niet benoemd zijn; AD gebruik bijv.
[] IaC-code voor aanmaken resource group
[] IaC-code voor aanmaken storage account

[] IaC-code voor het netwerk en alle onderdelen w.o. avail zones
[] IaC-code voor een webserver 
[] IaC-code voor een management server
[] IaC-code voor scripts(niet publieke toegankelijk)
[] IaC-code voor versleuteling van **alle** data
[] IaC-code voor back-up voorzieningen.
[] Ontwerpdocumentatie voor de klant|in simpele termen
[] Configuratie voor een MVP deployment

### Eerste sprint
De minimale onderdelen voor de eerste sprint (voor 1 september af)
[x] Opsommen van vragen
[x] Opsomming van aannames na aanleiding van niet beantwoorde vragen.
[] IaC-code voor het netwerk en alle onderdelen
[] IaC-code voor een webserver en management server

### Eerste deel tweede sprint (8 september af)
De minimale onderdelen voor eerste deel van de tweede sprint (voor 8 september af)
[] IaC-code voor scripts(niet publieke toegankelijk)
[] IaC-code voor versleuteling van **alle** data
[] IaC-code voor back-up voorzieningen.

### Tweede deel van de tweede sprint (14 september af)
[] Ontwerpdocumentatie voor de klant|in simpele termen
[] Configuratie voor een MVP deployment
[] Werkend geheel
[] Opsomming van diensten die wel nodig zijn maar niet benoemd zijn

# De onderdelen van het systeem
Locatie: unknown

### Het netwerk:
2 Vnets
- peering tussen beide vnets
- 2 availability zones elk
- NSGs voor beide VNets met de volgende regels
```
conectie tussen web en management server via SSH/RDP
connectie naar management server mag alleen vanaf thuislocatie van manager
Webserver moet vanaf buiten bereikbaar zijn
```
2 subnets
- IP ranges 10.10.10.10/24 en 10.20.20.200/24

### Servers
2 servers: 1 webserver, 1 management server

Webserver:
IP public, SKU unknown 
OS, unknown
Subnet 1
Access controlled by AD, alleen bereikbaar vanaf management server 
Management server:
IP public ivm bereikbaarheid voor manager vanaf thuis locatie, SKU unknown, access controlled bij AD
OS unknown
Subnet 2

VM:
Type: Unknown
OS disk size: Unknown
Inbound ports: off. Gaat via NSG.
Back-up elke dag; tijd en type onbekend
Is binnen Azure, of binnen webserver zelf? Unknown
- bij geen antwoord: tijd 0:00 uur en zondag + woensdag volledig, rest incrementeel.
Disks alleen OS of ook data unknown

### Instellingen
AD tenant en NSG met regels:
- alleen manager mag toegang tot management systeem vanaf thuislocatie (AD Conditional Access)
- alleen vanaf management server toegang tot management deel van webserver via SSH/RDP

### Overige onderdelen
Storage account
Key Vault
Alles in 1 subscription

### Volgorde van handelingen:
-   Controleren van de opties per sectie.
-	Aanmaken resource group (dit ook als onderdeel van ontwerp doc)
-	Storage account
-	2 vnets met peering en 2 avail zones
-	2 subnets voor servers
-	VMs en servers
-	Instellen back-ups
-	Key vault, recovery vault


# Notes:
Public IP for SSH can be output via the output keyword
