# Ontwerp documentatie

Dit document bevat alle deliverables van de onderdelen van het uiteindelijke ontwerp waaronder:
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
Deze zijn:
1) De load balancer moet een Application Gateway zijn.
2) De scale set scaled uit als de CPU voor 10 minuten of meer een load heeft van 70%.
3) De scale set scaled in als de CPU voor 10 minuten of meer een load heeft van 25% 
4) Er wordt een diagnostic log bijgehouden van de auto scaling.
5) Scale-in is "default": deletion of highest instance ID first.
6) Geen force delete; dit om kwijt raken van user data te voorkomen.
7) Er worden boot diagnostics met managed storage account gebruikt.
8) De spreading algorithm is "max speed".
9) De grace period voor de automatic repair wordt 10 minuten; dit is de kortste periode.