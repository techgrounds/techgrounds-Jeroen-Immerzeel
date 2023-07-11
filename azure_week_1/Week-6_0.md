# Week 6
### Bestuderen van een aantal services.
Deze opdracht is zeer groot. Deze wordt in tweëen gedeeld.
De volgende services moeten gebestudeerd worden:
- Containers -> 6.0
- Support plans -> 6.0
- Advisor -> 6.1
- App configuration -> 6.0
- Activity log -> 6.1

De volgende services moeten praktisch onderzocht worden: 
- Active Directory -> 6.1
- Monitor -> 6.1
- CosmosDB -> 6.0
- Functions -> 6.0
- Event grid, Queue storage, Service bus.



# Functions / Function app
Functions en *logic apps* maken het mogelijk om **serverless** applications te ontwikkelen. 
Funtions is een compute service en logic apps een *workflow integration platform*
Functions ondersteunen *triggers* en *bindings*:
Triggers zijn manieren om de executie van de code te starten.
Bindings zijn een manier om input en output van data te versimpelen.
Beiden kunnen zorgen voor orchestrations.

Functions gebruiken de *durable function extention* en logic apps een GUI voor het aanpassen van de configuration files.

De verschillen zijn weergegeven in dit overzicht:
![Overzicht met de verschillen tussen Functions en Logic apps](/00_includes/Cloud2/functions_1.png)

Functions kent 3 hosting plans met x/y instances:
- Consumption: default 200/100 instances(W/L)
- premium: krachtigere hardware, connects to VMs, 100/20-100 (W/L)
- Dedicated: runs in a App Service plan, best for long running scenarios 10-20

En er zijn 2 andere opties met meer control en isolation:
- ASE: App Service Enviroment: volledige geisoleerde en dedicated enviroment. 100
- Kubernetes varies

Om functions te gebruiken is een *storage account* nodig; 2 als er storage-intensive operations moeten gebruikt worden.

Alle functions in een function app delen de resources van de instance. Het controleren van de scaling van function apps wordt gedaan via een *scale controller* welke heuristics voor elk trigger type gebruikt om te bepalen of er geschaald moet worden.
Er kan tot 0 instances gedownscaled worden, en tot een vast aantal geupscaled. Voor HTTP triggers wordt er maximaal 1 instance per seconde aangemaakt, voor niet-HTTP triggers is dit 30 seconden.   
Het maximale aantal instances kan worden aangepast met de ```functionAppScaleLimit``` -value waarbij 0 of null ongelimiteerd is.


## App configuration
App configuration is een service om het gecentraliseerd managen van application settings en feature flags.
De voordelen zijn:
- Snel op te zetten
- Flexibele key representations en mappings
- Tags
- Point-in-time replay voor settings
- Dedicated UI voor feature flag management
- Het kunnen vergelijken van 2 cconfiguratie sets binnen zelf gedefinieerde dimensies
- Beveiliging via Azure-managed Identities
- Encryptie
- Integratie met populaire frameworks

De populaire frameworks zijn:
- .Net
- Java Spring
- JavaScript/Node.js
- Python

App configuration complementeerd Azure Key vault.

___
## Gezien ik vorige week zowel Containers als CosmosDB al onderzocht heb kopieer ik de stukken over deze 1 op 1.

# Docker Containers

Docker is een van de belangrijkste platformen om Containers mee te hosten.
Containers zijn, net als Virtual Machines, gevirtualiseerde omgevingen. Het verschil met VMs is dat waar VMs de onderliggende hardware simuleren, containers alleen het OS simuleren. Dit betekent wel dat containers altijd gebonden zijn aan de kernel van de host OS; een Linux container op Windows kan niet, een Windows VM op een Windows server, kan wel.

Containers bevatten alle instructies om te draaien, en starten dan ook razendsnel op.
Om containers op te zetten kan er handmatig worden gewerkt, of via orchestration. Orchestration automatiseerd het opzetten, aanpassen, afbreken en alle secundaire functies voor een gecontaineriseerde omgeving. Een belangrijke optie voor orchestration is **Kubernetes**; Azure biedt hiervoor de **Azure Kubernetes Service**, **AKS**, voor

### Voordelen van containers
Enkele belangijke voordelen van containers zijn:
- Separatie: containers vormen geheel eigen instances met eigen hardware. En zijn daardoor relatief veilig.
- Snel opbouwen: een container aanmaken en starten gaat heel snel.
- Orchestratie: containers kunnen door orchestratie makkelijk worden beheert.
- Schaalbaar: doordat containers lightweight zijn kunnen er veel containers op 1 systeem worden gebruikt.

### Docker op Azure

Om een simpel systeem voor Docker containers op te zetten kan er een Linux VM worden aangemaakt.  
Om een wat complexer systeem te beheren waarbij de containers via orchestration moeten worden beheert wordt er een kubternetes cluster aangemaakt via de **Azure Kubernetes Service**.
   
## Hoe kan een container worden aangemaak?
### Het opzetten van een Linux VM met containers.

Het aanmaken van een VM gaat via de *create new resource* -> Virtual Machines optie.
Hierbinnen wordt een Linux versie gekozen en de rest alleen de verplichte onderdelen ingevoerd of standaard gelaten.

Na het aanmaken van de VM en het inloggen op de VM via SSH moet de VM worden geüpdated met ```sudo apt update``` en  ```sudo apt upgrade -y```.
Om Docker te installen moet het commando ```apt install docker.io -y```; hiermee wordt Docker geinstalleerd.

### Het opzetten van een Docker container

Om met Docker een container op te zetten wordt er vooraf een programma gekozen; dit kan een database zijn, een WordPress server of een ander OS. Dit zolang het programma of OS maar Linux-based is.
```
Note:

Gezien ik ooit hoop in CyberSecurity te gaan werken, en dan speficiek als pentester, kies in deze voor een Kali Linux container.
```
Om de gekozen image te downloaden en vervolgens als container te draaien zijn deze 2 commando's nodig:
```docker pull [image name]```  
```docker run -dt --name[gekozen container naam] [image name]``` 

Dus in deze wordt het commando om de Kali Linux image te gebruiken:  
```docker pull kalilinux/kali-last-release```  
En om deze te gebruiken:  
```docker run -dt --name kali kalilinux/kali-last-release```  

Om de gestartte container te bekijken wordt het commando ```docker ps``` gebruikt.  
Om naar de gestartte container te gaan wordt het commando ```docker exec [shell name] [gekozen container naam]``` gebruikt.  
Dus om de Kali container te gebruiken is het commando:  
```docker exec bash kali```  

![Docker pull](/00_includes/Cloud2/docker_pull.png)
*docker pull*

![Docker run](/00_includes/Cloud2/docker_run.png)
*docker run*

![Docker ps](/00_includes/Cloud2/docker_ps.png)
*docker ps*

![Docker exec](/00_includes/Cloud2/docker_exec_kali.png)  
*Kali in Ubuntu*

Om dit systeem op te zetten was nog geen 5 minuten nodig waarvan de container zelf binnen een minuut geladen was. Dit laat de kracht van containers qua snelheid goed zien.

### CosmosDB
CosmosDB is een veelzijdige SQL en NoSQL database, en kent 4 verschillende data typen dat deze kan opslaan:
- Graph: verbind complexe relaties tussen entiteiten. 
- Document DB: voor semi-getructureerde data waarbij gebruik gemaakt wordt van .JSON files.
- Key Value-store: hierin wordt data met een simpele key value opgeslagen.
- Column-familiy: voor het organiseren van data in families met rows met gelijke structuur

De kracht van CosmosDB zit 'm in het feit dat alle data gerepliceerd kan worden over meerdere Azure regions. Dit levert een zeer snelle replicatie op en ook een zeer korte toegangstijd. 

CosmosDB heeft de optie om met verschillende API's te werken:
- NoSQL
- SQL(PostgreSQL)
- MongoDB 
- Table Storage
- Apache Cassandra 
- Apache Gremlin
Dit maakt ook de interactie met de database zeer veelzijdig. 

Ook de integratie met Azure services en development frameworks is zeer krachtig door de native support.

### Aanmaken van een CosmosDB
Voor het aanmaken van een CosmosDB wordt er binnen de portal op cosmosDB gezocht.
Op de CosmosDB overview wordt ```create``` gekozen om een CosmosDB aan te maken; hierbij wordt gekozen voor een van de APIs die CosmosDB ondersteund.

![De verschillende APIs](/00_includes/Cloud2/cosmos_api.png)
*De verschillende APIs*

Bij het aanmaken van de database kan er gekozen worden voor een free-tier; deze kent een limitatie van 1000RU/s en 25Gb storage. RU/s, of "request units per second" is een genormaliseerde unit om te bepalen hoeveel hardware resources het gebruik van een systeem kost, zoals in deze een database request. In ComosDB is een "point read" voor een 1KB item, 1 RU/s, en een point read van een 100-KB item 100 RU/s. Andere handelingen kunnen meer RU/s kosten. 

![Free tier limitations](/00_includes/Cloud2/cosmos_free.png)
*De limitaties van de free tier*

Na het bepalen voor de instellingen van de database wordt de te verwachten tijd voor het aanmaken van de database vermeldt; wat best een handige feature is.

Nadat de database is aangemaakt kan je een container aanmaken voor alle data. Dit kan voor verschillende talen worden gespecificeerd, waaronder Python en .NET.


Het CosmosDB settings overzicht kent heel veel opties waaronder het instellen van backups, global replication en networking opties.

![CosmosDB settings options](/00_includes/Cloud2/cosmos_settings.png)  
*CosmosDB settings*


#### Managed instance
Het is ook mogelijk om een "managed instance" te maken. Dit is een database die grotendeels beheert wordt door Azure zelf en specifiek ontworpen is om samen te werken met een on-premise database. Daarnaast is dit een "dedicated solution": de resources voor deze database worden niet gedeeld.  

# Event Grid, Queue Storage, Service Bus


**Event grid** is een manier om events van 1 service naar een andere service door te sturen. Dit is primair voor IoT solutions.

**Queue storage** is een soort van load balancer om berichten tussen apps zo te versturen dat de ontvangende app niet overstroomd wordt.

**Service bus** is een manier om asynchroon berichten te versturen tussen applicaties.  

Alle 3 kunnen simpel worden bereikt door naar hun naam te zoeken.


# Azure Support Plans
4 tiers: basic developer, standard, professional direct
Kosten zijn gratis, €29, €100 of €1000.


