# Documentatie versie 1.1

Dit is een overzicht van de documentatie voor *Project v1.1*  
Er worden x documenten aangemaakt:
1) De beschrijving van de *eisen* en *aannames*; deze staan in dit document
2) De *user stories* van de features die worden gevraagd voor dit project
3) De deliverable voor een *architectuurtekening*  
3) *Daglogs*; elke dag zal er een korte beschrijving worden gemaakt met de gedane werkzaamheden en eventuele hindernissen die er zijn geweest of opgelost zijn. Dit is een apart bestand.
4) *Presentaties*; er wordt door mij op vrijdag 22 september een sprint review gehouden en op 6 oktober een eindpresentatie; voor beiden zijn de nodige documenten nodig. Dit zijn, logischerwijs, apart bestanden.




# Ontwerp documentatie

Dit zijn alle deliverables van de onderdelen van het uiteindelijke ontwerp waaronder:
1) Een puntsgewijze beschrijving van alle eisen
2) Een beschrijving van alle aannames
3) Een beschrijving van alle diensten
4) Een volledige omschrijving van het systeem
5) Een architectuur tekening
 
# Deliverable 1: 
**Een puntsgewijze omschrijving van alle eisen**

De klant heeft al een aantal eisen omschreven en deze worden hier puntsgewijs opgesomd:
1) De webserver(s) mag/mogen alleen via een proxy/gateway worden benaderd en mag géén publiek IP adres meer hebben.
2) Er moet een scale set komen voor de webserver om tijdens zware belasting deze op te vangen.
3) Er moet een load balancer komen
4) De load balancer moet een HTTPS verbinding verplicht stellen en eventueel een HTTP-verbinding automatisch upgraden. 
5) De encryptie van de verbinding met de webserver moet TLS 1.2 of hoger gebruiken.
6) Er moeten health checks op de webserver plaats vinden en eventueel automatisch herstel.
7) Gezien er nog geen domeinnaam is wordt er een self-signed certificate gebruikt.



# Deliverable 2 
*Een beschrijving van alle aannames.*

Door de eisen van de klant zijn er een aantal aannames die er genomen zijn. 

### De aannames zijn voor de load balancer:
1) De load balancer moet een Application Gateway zijn.
2) Moest een redirection methode hebben om HTTP verkeer te leiden naar HTTPS
3) Moet een Standard_V2 sku zijn.
4) Moet de healthprobes hebben
5) Moet een eigen IP adres hebben 

### De aannames voor de VMSS zijn:
1) Geen force delete; dit om kwijt raken van user data te voorkomen.
2) Er worden boot diagnostics met managed storage account gebruikt.
3) De spreading algorithm is "max spreading".
4) De grace period voor de automatic repair wordt 10 minuten; dit is de kortste periode.
5) Er worden boot diagnostics bijgehouden met een managed storage account
6) Er wordt een "instance termination" notification gegeven met een delay van 5 minuten.
7) application monitoring gaat via HTTP, port 80, binary, en request path is '/

### De aannames voor de autoscaler zijn:
1) De scale set scaled uit als de CPU voor 10 minuten of meer een load heeft van 70%.
2) De scale set scaled in als de CPU voor 10 minuten of meer een load heeft van 25% 
3) Er wordt een 'Flexible' Orchestration mode gebruikt.
4) Er wordt een diagnostic log bijgehouden van de auto scaling.
5) Scale-in is "default": deletion of highest instance ID first.

### De aannames voor de andere onderdelen
1) Deze zijn, op wat kleine aanpassingen na, hetzelfde als bij V1.0 