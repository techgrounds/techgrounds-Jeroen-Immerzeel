# Bicep informatie
Dit document bevat links naar bronnen over het gebruik van Bicep en een aantal code snippets om de syntax van bicep en de opties te beschrijven.

# Handige bronnen voor het gebruik van Bicep
Microsoft Learn:
https://learn.microsoft.com/nl-nl/azure/azure-resource-manager/bicep/
https://learn.microsoft.com/en-us/azure/templates/
https://learn.microsoft.com/nl-nl/azure/azure-resource-manager/templates/

Youtube:
https://youtu.be/VDCAJIGqHZU?si=1ADclXnjqej9NruE tuturial by Microsoft Azure
https://www.youtube.com/watch?v=MP60ND7Upn4&list=PLlrxD0HtieHjzqIRjPoERUGj49rve3rCM playlist by Azure
https://youtu.be/_yvb6NVx61Y?si=qOvng4NrtbZce93L tutorial by John Savill

# General info
location 
Germany West Central locatie is germanywestcentral als string
Deploy met ```az deployment group create --template file main.bicep parameters environmentType=nonprod```
Resource group wordt bepaald via de CLi met ```az configure --defaults group=ProjectCloud11```
Zet default types voor variables op 'nonprod' en pas deze later aan naar 'prod'; zet hierbij ook de goedkopere alternatieven voor resources als nonprod optie


# Basic commands
de belangrijkste:
```az deployment group create -f [file]```
```az deployment group what-if -f [file]```
```az bicep decompile --file main.json```


```az configure --defaults group=''```
```az deployment group create --template-file main.bicep``` voor het deployen van een template
```az deployment group list --output table``` lists de aangemaakte resources in de resource group 
```az deployment sub create etc``` om een resource group te maken 
```az deployment mg create etc``` om een subscription aan te maken (dit kan ik niet)

```az group delete --name name``` om een resource group te verwijderen

```az deployment group what-if --template-file``` maakt het mogelijk om een dry run te starten

```az bicep build -f .\filename``` laat de .json output van de bicep zien

```bicep build -f file.bicep``` vertaald bicep naar json

Met de ```--parameters parameterfile.json``` argument is het mogelijk om een parameter file aan te geven
# Basic Bicep code snippets

Dit bestand zal een aantal snippets met bicep code bevatten. Dit ter referentie.



# create storage account
```
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSkuName
  }
  properties: {
    accessTier:'Hot'
 }
}
``` 

De onderdelen:
```resource``` keyword om een resource te definiëren
```storageAccount``` om een naam te geven aan de resource 
``` 'Microsoft.Storage/storageAccounts@2022-09-01' ``` geeft het type resource aan; in dit geval een StorageAccount
Andere onderdelen zijn per resource verschillend en zijn al dan niet verplicht.

Verplichte onderdelen kan je via de autocompletion binnen VSCOde automatisch laten aanvullen na de *=*.


# Parameters
Parameters kunnen worden gebruikt om vooraf benodigde data toe te voegen en te refereren.
Het ```param``` keyword geeft aan dat er een parameter wordt gedefinieerd.

```param location string = 'westus3'``` voor resourcegroup locatie en ```param location string = resourceGroup().location``` voor de modules met alle andere resources in combinatie met ```location = location``` 

```
param storageAccountName string = 'namestring${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'namestring${uniqueString(resourceGroup().id)}' 
```

Om benamingen binnen Azure op een duidelijke manier te ordenen is het mogelijk om via string interpolation automatisch een affix aan een string te laten toevoegen. In deze wordt er een naam aangemaakt met syntax "namestring"+affix. Dus bijvoorbeeld 'namestringa3j9h8'

Met de @description -decorator kan ook een description toevoegen:
```
@description('This is a description decorator and its description')
```

het ```@secure``` parameter wordt gebruikt om gevoelige informatie uit te sluiten van logging in de deployment logs. Ook wordt er bij het eventueel handmatig invoeren van gevoelige data deze niet getoond als output in de terminal.

Parameters kunnen in een parameter file staan
Parameters kunen worden overschreven door het ```--parameters``` argument te gebruiken tijdens deployment. Hierbij is het ook mogelijk om de files vastgestelde parameters alsnog aan te passen. 


# resource tags
Resource tags kunnen met deze syntax worden gedefinieerd: 
``` 
param resourceTags object = {
  tagName: tagValue

}
```
# Variables


```
@allowed([
  'nonprod'
  'prod'
])

param environmentType string
```

# Aanmaken van meerdere resources
Via een for loop kan je aangeven dat er meerdere identieke resources moeten worden aangemaakt:

```
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = [for i range(0,2)] : {
  ```



# vnets
Om een subnet in een vnet te plaatsen is de syntax:
```
properties: {
    addressSpace: {
      addressPrefixes: [
        'IP range' (string!)
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: 'IP range'  (string!)
        }
      }
    ]
  }
```


# Integratie met Azure Vault

Bij het gebruik van een Azure vault worden sercrets alleen door referentie benoemd.
De basale syntax is dan

```
parameter
```



# tmp

