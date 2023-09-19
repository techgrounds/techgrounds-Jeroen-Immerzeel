# Beslissingen
Dit document gaat gelden als een overzicht van de gemaakte beslissingen en aannames voor het project, versie V1.0
Voor elke deliverable wordt een overzicht gemaakt van de beslissingen, aannames en overwegingen die ik gemaakt heb en het waarom. 

Mochten beslissingen worden teruggedraaid of aangepast zullen deze met een ~~doorstreping~~ genoteerd worden en een reden van deze verandering worden genoteerd.

# Deliverables voor de Epic Exploratie
Hieronder zal ik een overzicht geven van de verwachtte deliverables:
1) Een puntsgewijze omschrijving van alle eisen
2) Een puntsgewijze omschrijving van alle aannames
3) Een overzicht van alle diensten die gebruikt gaan worden
4) IaC-code voor het netwerk en alle onderdelen
5) IaC-code voor en webserver en alle benodigdheden
6) IaC-code voor een management server met alle benodigdheden
7) IaC-code voor een opslagoplossing voor scripts
8) IaC-code voor versleuteling voorzieningen
9) IaC-code voor backup voorzieningen
10) Documentatie voor het gebruik van de applicatie
11) Configuratie voor een MVP deployment

# Beslissingen per deliverable:
Hieronder worden de deliverables opgesomd met aantekeningen: 
## Deliverable 1:
*Een puntsgewijze omschrijving van alle eisen*  
Deze opsomming staat in het document **overzichtEisen_project_v1.0**


## Deliverable 2:
*Een puntsgewijze omschrijving van alle aanames*  
Dit staat in het document *overzichtAannames_project_v1.0*

## Deliverable 3:
*Een overzicht van alle diensten die gebruikt gaan worden*  
Dit staat in het document*OntwerpDocumentatie_project_v1.0*

## Deliverable 4, 5, 6:
*IaC-code voor de onderdelen: netwerk, webserver, managementserver,* 
Dit staat in het bestand *VM_networking.bicep*, in de map Project/
## Deliverable 7, 8 en 9:
*IaC-code voor een opslagoplossing voor scripts, versleuteling en backup voorzieningen*
Deze staan in het *main.bicep* bestand.

## Deliverable 10: 
*Documentatie voor het gebruik van de applicatie*
Dit staat in het bestand *deployment_information.md* in de map Project_documentation/

## Deliverable 11:
*Configuratie voor een MVP deployment*  
Hierbij gaat het puur om een Minimal Viable Product; dus alleen de basis. Daarom ga ik er vanuit dat dit zonder aanpassingen vanuit mijzelf is.
Dit gaat na de hand van het diagram zoals deze in de opdracht staat.
![Het ontwerp uit de opdracht](/00_includes/IaC/ontwerp_azure_opdracht.png)
Dit zal ik stap voor stap omschrijven in het bestand **ontwerpDocumentatie_project_v1.0**


