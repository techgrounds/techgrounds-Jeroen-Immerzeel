# Bicep lessons
# Random facts
Om de lengte van een namestring te trimmen wordt het 'take' keyword gebruikt en na de string interpolation een lengte bepaald. 
 ```
 var auditStorageAccountName = take('bearaudit${location}${uniqueString(resourceGroup().id)}', 24)

 ```
Hier is 24 de lengte van de string. 

# Conditionals and loops
## conditionals
Conditionals zijn booleans en worden gebruikt om te komen tot een opdracht waarbij er wel of niet een resource gedeployt moet worden. Hierbij kan een parameter of varaiable vergeleken worden met een bepaalde situatie zoals het al dan niet aanwezig zijn van een andere resource, of dat de omgeving waarvoor de deployment is bedoeld een bepaalde waarde heeft. Denk hierbij aan production, development e.d.
Een voorbeeld van een conditional is:
```
resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2021-11-01-preview' = if (environmentName == 'Production') {

``` 
Hierbij wordt de auditSettings alleen gedeployt als de environmentName parameter 'production' is. 

Een voorbeeld voor ons project is het niet aanmaken van secrets tijdens het testen, maar wel tijdens de uiteindelijk MVP deployment. 
Dit kan door de conditional deployment te combineren met een expression evaluation zoals deze:
```
@allowed [(
    'prod'
    'nonprod'
)]
param environmentName string

resource name definition if (other_resource_is_enabled) = {
resource_property: environmentName == 'prod' ? do_something : ''
} 
``` 

In dit voorbeeld wordt de resource alleen aangemaakt als "other_resource_is_enabled" True is, dus ook aangemaakt wordt, en de resource_property wordt alleen gebruikt mocht de environmentName 'prod' als waarde kennen. 

Belangrijk hier is om te weten welke resources er op elkaar aansluiten. Een storage blob aanmaken zonder een storage account zal niet werken.

## Loops
Loops worden aangemaakt via het ```for``` keyword en een array die de resource definitie bepaald.
Een array wordt gemaakt door een parameter met een aantal strings die tussen een [] staan.

Dus als voorbeeld:
```
param array [
    'one'
    'two'
    'three'
]

resource name resource/type = [for x in : {
    resource definitie
}
]
```

Dit zal 3 kopieën van de resource maken; elk met 1 van de 3 namen in de array

Ook is het mogelijk om een x aantal van een dezelfde resource aan te maken; hierbij wordt de statement voor de loop 
```
[for i i range(x,y)]
```
X is hierbij de starting value en Y het aantal resources dat er aangemaakt moet worden: ```for i in range(0, 4)``` maakt dus 4 resources aan.

Hierbij zijn x en y ook de output van de loop. Deze kunnen worden gebruikt in combinatie met string interpolation om zo values te maken met als onderdeel de output van de loop.
Als voorbeeld hiervan is de naam van een resource:
```
name: 'sa${i}'
``` 
De name wordt in deze sa0, sa1 enz. 
Hierbij is het zo dat x de naam bepaald en dat er spraken is van zero indexing.


Een heel krachtige manier om loops te gebruiken is om binnen een array properties te zetten en binnen de loop voorwaarden te bepalen waarbij er wel of geen sprake is van het gebruik van de loop:
```
param serverTypes array = [
{
    name: 'devServer'
    location: 'westus3'
    environmentName: 'dev'
}
{
    name: 'productionServer'
    location: 'westeurope'
    environmentName: 'prod'

}
]

resource name resource/Type = [for serverType in serverTypes if (serverType.enviromentName == 'prod')
    resource_property: definitions
]
```
In dit voorbeeld wordt er een production server gemaakt in de westeurope region gezien de loop de voorwaarde krijgt dat deze resource aangemaakt wordt mits de environmentName value van de serverType parameter 'prod' is. 
Het is hier natuurlijk mogelijk om de parameter aan te passen door deze bij deployment in te geven.


Met het @batchsize() decorator wordt het aantal handeling per batch bepaald.
Dus met ```@batchsize(2)``` worden er 2 handelingen per batch uitgevoerd.
Met ```@batchsize(1)``` worden de handelingen in sequentie uitgevoerd; de ARM zal dus eerst de handelingen voor de eerste resource uitvoeren om daarna pas de tweede uit te voeren.

het is ook mogelijk om resource properties te bepalen.
Een zeer krachtige manier om subnets te bepalen is met een ```[for (subnetName, i) in subnetNames:{}]``` defintie in combinatie met de addressPrefix property welke met string interpolatie een prefex kan krijgen gebaseerd op de ```subnetName, i``` statement.

Ook zijn nested loops mogelijk.

Ook met variables zijn loop mogelijk. Een voorbeeld hiervan is het bepalen van de addressranges van subnets:
```
var subnetsProperty = [for subnet in subnets: {
  name: subnet.name
  properties: {
    addressPrefix: subnet.ipAddressRange
  }
}]
```
Hiermee kan je de subnetsProperty variable gebruiken als value voor de subnet addressrange.



# Gebruik van secrets

Het gebruik van secrets zoals usernames en passwords moet op een veilige manier gebeuren. Dit kan met de @secure decorator. Voorbeeld:
```
@secure()
param adminLoginName string

@secure
param adminLoginPassword string
```

Hier wordt de secure-decorator gebruikt om de input van de adminLoginName en adminLoginPassword parameters te beveiligen. Hierdoor wordt er tijdens de deployment om een username en password gevraagd ter input. Tijdens het ingeven van de input wordt de input zelf niet getoond.

