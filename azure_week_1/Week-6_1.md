# Week 6 | 6.1

Deze opdracht is zeer groot. Deze wordt in tweeën gedeeld.
De volgende services moeten gebestudeerd worden:
- Containers -> 6.0
- Support plans -> 6.0
- Advisor -> 6.1
- App configuration -> 6.0
- Activity log (& monitor) -> 6.1

De volgende services moeten praktisch onderzocht worden: 
- Active Directory -> 6.1
- Monitor (& Activity log) -> 6.1
- CosmosDB -> 6.0
- Functions -> 6.0
- Event grid, Queue storage, Service bus. -> 6.0

# Active Directory
Azure Active Directory (AAD) is een Identity as a Service oplossing en de cloud opvolger van AD. AAD beheert naast de standaard entities (Users, Groups en systems) ook apps.

Een paar belangijke concepten:
Users: individuele gebruikers van het systeem
Groups: groepen met users die dezelfde rechten hebben
Devices: systemen die net als gebruikers in groepen kunnen worden geplaatst.  
Federation: domain A en domain B kunnen door federation elkaars authentication services vertrouwen. Dit wordt ook wel een *trust 
relationship* genoemd.


# Monitor

## Activity Log
Is onderdeel van de Monitor service.
Is een platform log dat inzicht geeft in events op subscription level.
Logs worden voor 90 dagen bewaard; voor langere retentie is het nodig een aparte locatie voor opslag te bepalen.

In de change history tab kan bekeken worden hoe resources de laatste 30 minuten voor een operation veranderd zijn.

Andere manieren om het activity log te bekijken zijn:
- De GetAZLog cmdlet voor powershell.
- het az monitor activity-log ommando in Azure CLI
- De Azure Monitor REST API

# Advisor 
Advisor is een analyse tool dat adviezen geeft om het systeem aan de 5 pillars van het Well-Architected framework te laten voldoen.

Advisor kan op subscription level en resource level werken. Advisor geeft hiervoor een **Advisor Score** van 0 tot 100%; gebaseerd op hoe goed het systeem zich aan de best practices houdt.

Advisor kan problemen oplossen via quick fix.