#Deliverable 2 
**Een puntsgewijs overzicht van alle aannames**

Dit document bevat alle aannames en beslissingen voor het ontwerp

**algemeen**  
De naam die ik geef aan de onderdelen van dit project is projectcloud11 (of pc11 als resource naam te lang mocht zijn)  
Om de benaming van resources duidelijk te houden wordt de syntax ```ProjectCloud11-resource```  dus bijvoorbeeld```ProjectCloud11-mngtVM``` of ```PC11-vnet1``` 


**Resource group**  

**Storage account** 
- Gebruik van redundancy is altijd nodig. Bij uitval van datacenter kan er dan toch nog een omgeving wordt gedeployt. Ik kies daarom voor GRS.  
- Er wordt gebruik gemaakt van een private link. Dit om zo alleen toegang vanaf het interne netwerk mogelijk te maken.  
- Soft delete en versioning is nodig om zo het onbruikbaar maken of verwijderen van de scripts te voorkomen.

**Vnets** en  **subnets**
 - Peering tussen de vnets is nodig gezien beide servers in een apart vnet staan en er een veilige connectie moet worden gemaakt. 
 - Om de beveiliging te vergroten wordt de connectie van het webserv vnet naar het mngt vnet gesloten maar die van de mngt vnet naar het webserv vnet geopend. Zo kan de management server nooit vanuit de webserver bereikt worden bij een eventueel lek maar de webserver wel door de management server bereikt worden. 





**Beveiliging servers**
Voor de beveiliging van de servers neem ik aan dat:
- Er gebruik gemaakt moet worden van in ieder geval NSG rules
- De webserver beheert zal worden via SSH of RDP (eisen OS nog onduidelijk)
- De management server kan alleen bereikt worden via NSG firewall regels of RBAC
- De encryptie voor de servers gaat via de optie *platform managed key*; dit is de meest simpele manier, maar heeft toch wat setup nodig (zie https://learn.microsoft.com/en-us/azure/virtual-machines/disks-enable-host-based-encryption-portal?tabs=azure-powershell#prerequisites)
- De optie *NIC network security group* op *none* gaat gezien deze al via NSGs worden beheerd
- *afweging*  ~~wordt de management server login met AD geactiveerd?~~ *aanpassing* voor de connectie met de management server wordt de NSG regel "allow source: my IP address" gebruikt
- *afweging* liggende aan het antwoord van de PO: de optie voor automatische back-ups via Azure of via OS
- Alerts worden aangezet. Dit voorkomt onnodige problemen die in een vroeg stadium via monitoring worden ontdekt

**Servers algemeen**
- De webserver wordt een Linux server. Dit maakt het opzetten een heel stuk simpeler door het gebruik van een custom script bij het aanmaken van de VM
- Er worden standard SKU Public IP adressen aangemaakt want alleen standard SKU kent ondersteuning voor availability zones
- *afweging* ~~Gezien de management server in availability zone 1 moet staan en de kosten voor gebruik daarbij omhoog gaan moet ik rekening houden met het budget van de PO.~~ -> Gebruik van Germany West location is mogelijk; is binnen scope van opdracht en heeft AZs voor Standard_B1s VM type

- De management server wordt een Windows 11 VM. Dit om gemak van de GUI, SSH via powershell/cmd en login via RDP dus build-in voor meeste systemen thuis.  


**key vault**
- Er is een kans dat de keys voor login per ongeluk verwijderd worden. Hiervoor wordt de purge protection optie aangezet.   
- Alleen de admin mag toegang krijgen tot de vault. Hiervoor wordt Azure RBAC gebruikt; de admin de owner-role.