# BICEP Tutorial

Dit zijn de aantekeningen en voorbeelden vanuit de Microsoft learn module over Bicep.


## Declarative code

Bicep werkt anders dan een Bash of Azure CLI script.
De layout is wel heel simpel om te lezen.
De volgende 2 voorbeelden doen alle twee hetzelfde:

![Voorbeeld van een Azure CLI script](/00_includes/IaC/MSL_example_1.png)  
*Azure CLI*

![Voorbeeld van een Bicep script](/00_includes/IaC/MSL_example_2.png)  
*Bicep*

Bicep en JSON zijn beiden geldige template languages voor de resource manager, maar Bicep is een heel stuk simpeler om te leze. 

![Vergelijking tussen Bicep en JSON](/00_includes/IaC/MSL_example_4.png)
*Vergelijking tussen Bicep en JSON*

Van een Bicep template wordt een ARM template gemaakt in JSON notering.
ARM templates worden door de Resource manager gelezen en daarna gevalideerd en geautorizeerd alvorens de aanpassingen aan de resources binnen de ARM template worden doorgevoerd.

Dit kan geheel binnen de Azure CLI waarbij een ```template-file *main.bicep*```  als argument gebruikt kan worden:

![Azure CLI met main.bicep argument](/00_includes/IaC/MSL_example_3.png)
*Azure CLI met main.bicep argument*

### Indeling van een Bicep template

Bicep maakt het mogelijk om via *modules* grote deployments in kleinere onderdelen op te delen waarbij deze binnen de main template gerefereerd kunnen worden.


Een bicep template bestaat uit een aantal onderdelen:

![Een bicep template](/00_includes/IaC/MSL_example_5.png)
*een bicep template*

De onderdelen in dit voorbeeld bestaan uit een resource definition en resource properties:  
```resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01'``` is de resource definition en bestaat uit 3 onderdelen:
- **resource** bepaald dat er een resource gedefinieerd wordt.  
- **storageAccount** is een symbolic name die puur bedoeld is om te refereren binnen het template  
- **Microsoft.Storage/storageAccounts@2022-09-01** is de resource type (Microsoft.Storage/storageAccounts) en de API version (@2022-09-01)

De andere onderdelen als **name, location en kind** zijn resource de properties.

VSCode heeft een uitgebreide Intellisense en validatie voor Bicep. Deze helpt o.a. met het vinden en noteren van de juiste API's en syntax.


# Common commands
Voor de deployment van een template:
**az login** om in te loggen op Azure
**az configure --defaults group=<resource group>** waar <resource group> de naam van de resource group is waarin de resources standaard in aangemaakt moeten worden
**az deployment group create --template-file <file>** waar <file> de naam van de bicep-file is.

# Variables en parameters:
**variables** worden aangewezen in het template en kunnen later in het template worden gerefereerd. 

**parameters** worden opgegeven bij deployment; dit kan handmatig, via een *parameter file* of binnen de pipeline.   

#### Parameters
- Gebruiken het **param** keyword.
- Krijgen een naam
- Na de naam komt het type; dit kan zijn *string*, *int*, *bool*, *array*, *object*; met ```= '<name>'``` krijgt een parameter een default name 
- voorbeeld: ```param vnetName str```

Parameters zijn vooral handig omdat regels voor bijvoorbeeld de unieke namen en vaste locaties van resources; de regels hiervan onthouden is lastig. 

Een goed gebruik voor een parameter is bepalen dat een resource altijd aangemaakt wordt op een vaste locatie; die van de standaard resourcegroup. Dit kan met ```param location string resourceGroup().location```. Met deze parameter set kan je in de main.bicep template de regel ```location = location``` plaatsen om zo de parameter te gebruiken.

Ook kunnen parameters worden gebruikt om zo de benaming van resources uniek te maken, waarbij de **resource group id** gebruikt wordt:  
-  ```param storageAccountName string = uniqueString(resourceGroup().id)```linkt de ID van de resourcegroup en de naam van een storageaccount.
-- ```param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'``` linkt ook de ID van de resourcegroup maar voegt deze aan de string 'toylaunch'. 


#### Variables
- Gebruiken het **var** keyword
- Krijgen een naam via de syntax *name = name* 
- voorbeeld ```var vnetName = 'vnet'```

# Output
Deployments kunnen output geven met informatie. 
Dit gaat via het ```output``` keyword.
De naam van de output en het type (string, bool, int etc) zijn nodig. Hierbij kanm de naam van de output hetzelfde zijn als de naam van de resource.
Een value moet altijd worden opgegeven voor elke output; dit kunnen *expresssions*, *references* to parameters of variables of *properties* van de resources zijn.

# Modules
Modules worden gedefinieerd met het ```module``` keyword waarbij de reference het file name is. Bijvoorbeeld:
```
module myModule 'modules/mymodule.bicp' = {
name: 'MyModule'
params: {
    location: location
 }
}
```

Modules kunnen output geven en deze output kan weer worden gebruikt door andere modules als parameters.

# Random notes:
[ ] Data plane en Control plane
Het verschil tussen de Data plane en Control plane is dat de Control plane de resources aanmaakt en de Data plane toegang geeft tot de features die de resources mogelijk maken. 