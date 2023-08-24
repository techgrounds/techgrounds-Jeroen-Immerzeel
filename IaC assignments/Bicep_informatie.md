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


# Basic Bicep code snippets

Dit bestand zal een aantal snippets met bicep code bevatten. Dit ter referentie.

# Basic commands
```az deployment group create --template-file main.bicep``` voor het deployen van een template
```az deployment group list --output table``` lists de aangemaakte group en resources

```az bicep build -f .\filename``` laat de .json output van de bicep zien

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
Parameters kunnen worden gebruikt om vooraf 
``` 
param location string = 'westus3'
param storageAccountName string = 'namestring${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'namestring${uniqueString(resourceGroup().id)}' 
```

Het ```param``` keyword geeft aan dat er een parameter wordt gedefinieerd.
Om een vaste locatie aan te geven kan deze via een parameter worden aangegeven. Dit is het meest simpele door de variabele "location" te gebruiken en als waarde de locatie.
Om benamingen binnen Azure op een duidelijke manier te ordenen is het mogelijk om via string interpolation automatisch een affix aan een string te laten toevoegen. In deze wordt er een naam aangemaakt met syntax "namestring"+affix. Dus bijvoorbeeld 'namestringa3j9h8'

# Variables

```@allowed([
  'nonprod'
  'prod'
])
param environmentType string```

# Aanmaken van meerdere resources
Via een for loop kan je aangeven dat er meerdere identieke resources moeten worden aangemaakt:
```resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = [for i range(0,2)] : {```