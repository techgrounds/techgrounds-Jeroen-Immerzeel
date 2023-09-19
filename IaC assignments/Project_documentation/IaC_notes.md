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
[x] Opsomming van diensten die wel nodig zijn maar niet benoemd zijn; AD gebruik bijv.
[x] IaC-code voor aanmaken resource group
[x] IaC-code voor aanmaken storage account

[x] IaC-code voor het netwerk en alle onderdelen 
[x] IaC-code voor een webserver 
[x] IaC-code voor een management server
[x] IaC-code voor versleuteling van **alle** data
[x] IaC-code voor back-up voorzieningen.
[x] Ontwerpdocumentatie voor de klant|in simpele termen
[x] Configuratie voor een MVP deployment

### Eerste sprint
De minimale onderdelen voor de eerste sprint (voor 1 september af)
[x] Opsommen van vragen
[x] Opsomming van aannames na aanleiding van niet beantwoorde vragen.
[x] IaC-code voor het netwerk en alle onderdelen
[x] IaC-code voor een webserver en management server

### Eerste deel tweede sprint (8 september af)
De minimale onderdelen voor eerste deel van de tweede sprint (voor 8 september af)
[x] IaC-code voor versleuteling van **alle** data
[x] IaC-code voor back-up voorzieningen.

### Tweede deel van de tweede sprint (14 september af)
[x] Ontwerpdocumentatie voor de klant|in simpele termen
[x] Configuratie voor een MVP deployment
[x] Werkend geheel
[x] Opsomming van diensten die wel nodig zijn maar niet benoemd zijn

# De onderdelen van het systeem
Locatie: 'Germany West Central'
Dit omdat daar wel alle resources aanwezig zijn én deze dichtbij is.

### Het netwerk:
2 Vnets
- peering tussen beide vnets
- 2 availability zones elk
- NSGs voor beide VNets met de volgende regels
```
conectie tussen web en management server via SSH/
connectie naar management server mag alleen vanaf thuislocatie van manager
Webserver moet vanaf buiten bereikbaar zijn
```
2 subnets
- IP ranges 10.10.10.10/24 en 10.20.20.200/24

### Servers
2 servers: 1 webserver, 1 management server

#### Webserver:  
IP public: Standard
OS: Linux
Subnet 1  
Alleen bereikbaar vanaf management server  

#### Management server:
IP public ivm bereikbaarheid voor manager vanaf thuis locatie, SKU: Standard
OS Windows Server 2022
Subnet 2

VM:  
Type: laat keuze over aan product owner; heb 3 beste keuzes gedefinieerd. 
OS disk size: standard size, 30 GiB  
Inbound ports: gaan via NSG.  
Back-up elke dag; tijd 0:00 uur.
Gaat via backup policy.

### Instellingen
NSG regels:
- alleen manager mag toegang tot management systeem vanaf thuislocatie 
- alleen vanaf management server toegang tot management deel van webserver via SSH
- Webserver kan worden bereikt via port 80 en 443 almede via SSH (port 22)
### Overige onderdelen
Storage account
Key Vault
Alles in 1 subscription

