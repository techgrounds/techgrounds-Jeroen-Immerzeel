# User stories

Dit document zal de user stories voor de benodigde onderdelen en features bevatten.
Gezien dit voor mij de eerste keer is dat ik deze maak zal ik eerst volgens een voorbeeld een standaard opmaak aanmaken en vanuit daar werken.

## Standaard opmaak.

In de eerdere versie van deze opdracht (versie 1.0) kregen wij de benodigde user stories aangeleverd, ik zal deze opmaak toevoegen als voorbeeld en gebruiken als opmaak voor de user stories van deze opdracht.

![Een voorbeeld van een User Story](/project_documentation/images/example_user_story.png)

# Epics
### Omschrijving van wat Epics zijn
Voor de User stories zijn meerdere "epics" nodig; dit zijn unieke periodes met een eigen functie; bijvoorbeeld het aanmaken van documentatie.
Elke periode bestaat uit een aantal deliverables; dit zijn bijvoorbeeld documenten of werkende code.

![voorbeeld van een overzicht van de Epics](/images/example_epics.png)

## De Epics die in dit project gebruikt gaan worden
Voor dit project worden er 2 Epics aangemaakt:  
Epic 1: *Exploration*  
Epic 2 *Bouw*

# Epic 1: Exploration

---
**User Story:**  
*Er is een duidelijke omschrijving nodig van de eisen*

**Epic:**  
*Exploration*

**Beschrijving:**  
Het ontwerp document beschrijft een aantal onderdelen. Al deze onderdelen moeten worden beschreven in een puntsgewijze omschrijving.  

**deliverable 1**  
Een korte omschrijving van alle eisen.
---
---

**User Story**  
*Er moet een overzicht komen van de gemaakte aannames*

**Epic**  
*Exploration*

**Beschrijving**  
Veel informatie staat al in het ontwerpdocument maar lang niet alle benodigde onderdelen worden er in vermeld. Er zullen dus een aantal aannames worden gedaan. Al deze aannames moeten worden geschreven.

**Deliverable 2**  
Een beschrijving van alle aannames.
---
---

**User Story**  
*Er zijn nog niet beschreven diensten, die wel beschreven moeten worden*

**Epic**  
*exploration*

**Beschrijving**  
Naast alle onderdelen die er gebruikt gaan worden, zijn er ook diensten die nodig zijn maar welke niet in het ontwerp document worden vermeld en/of in de architectuur vermeld worden. Deze moeten beschreven worden. 
 
**Deliverable 3**  
Een beschrijving van alle diensten die er gebruikt gaan worden.
---
---


**User Story**  
*Er is een architectuur tekening nodig* 

**Epic**  
*exploration*

**Beschrijving**  
De eisen moeten leiden tot een werkende architectuur welke opgetekend wordt.

**Deliverable 4**   
De architectuur tekening.
---
---

**User Story**  
*Er is een volledige omschrijving nodig van het gehele systeem*

**Epic**  
*exploration*

**Beschrijving**  
Nadat alle onderdelen puntsgewijs beschreven zijn moeten deze ook uitgebreid omschreven worden inclusief elke aanname en dienst.

**Deliverable**    
Een uitgebreide omschrijving van het systeem.


---
---

# Epic 2: Bouw

**User Story**    
*Er is een load balancer nodig*

**Epic**  
*bouw* 

**Beschrijving**  
Het systeem heeft een application gateway nodig die de VM scale set beheert. Deze load balancer/gateway heeft zelf een IP adres nodig.

**Deliverable**   
Werkende IaC code.
---
---

**User Story**    
*IaC code voor een VM scale set* 

**Epic**    
*bouw*  

**Beschrijving**   
Er is werkende code nodig voor een VM scale set waarbij er altijd minimaal 1 VM met webserver role actief is, en deze geschaald kan worden naar maximaal 3 instances. Deze scale set moet achter een load balancer staan en zodoende niet meer "naakt" vanaf het internet bereikbaar zijn maar alleen via de adminVM via ssh.  

**Deliverable**   
Werkende IaC code voor een VM scale set.

---
---

**User Story**    
*De scale set heeft health checks nodig die bij eventueel falen de VMs automatisch kan herstellen* 

**Epic**
*bouw*

**Beschrijving**  
De scale set moet stabiel blijven werken en heeft daarvoor regelmatige health checks nodig en een automatisch systeem van herstel mochten de health checks problemen constateren. 

**Deliverable**   
Werkende IaC code voor health checks voor de VM scale set.

---
---

**User story**  
*Het systeem mag alleen via HTTPS bereikt worden*

**Epic**   
*bouw*

**Beschrijving**  
Er is een self signed certificaat nodig om elke connectie met de load balancer/gateway via HTTPS te kunnen laten verlopen. 
 
**Deliverable**   
Een self signed certificate dat de load balancer gebruikt. Hierbij moet ook direct het gebruik van TLS 1.2 verplicht gesteld worden.

---
---

**User Story**  
*Er moeten aanpassingen komen aan meerdere onderdelen van de V1.0 app* 
**Epic**
*bouw*  

**Beschrijving**
Hoewel bijna alles gelijk blijft op de webserverVM na, het is wel nodig om een aantal kleine aanpassingen door te voeren op de backup, NSG en adminVM code.

**Deliverable** 
Aangepaste code voor backup, NSG en adminVM.