# Deployment

In dit bestand staan de stappen die er nodig zijn om de app te gebruiken en zal bestaan uit 3 secties: 
1) Pre-deployment
2) Deployment
3) Post deployment

Voor deze stappen zijn de IaC app files en Azure Cli nodig.
Hierbij wordt er van uitgegaan dat de cli working directory zich in de map ```/v1_1``` bevindt.

# Stap 1: pre-deployment.
In deze sectie worden aangemaakt: 
- Een Resource Group
- Een key vault
- Login secrets
- ssh key
- ssl certificaat

En bepaald voor later gebruik:
- Naam van de resource group
- Naam van de key vault
- Subscription ID
- IP adres van de administrator location


### Het aanmaken van een Resource Group:
Het aanmaken van een resource group gaat via dit commando:

```az group create -l <location> --name <RGname>```

Het is hierbij aan te raden om 'GermanyWestCentral' te gebruiken als **location**, en een duidelijke benaming voor de **RGname** op te geven.

Nadat deze is aangemaakt is het nodig om alle volgende commandos te gebruiken in de context van de resource group; hiervoor is het nodig om deze als default resource group te maken. Dit gaat via dit commando:

```az configure --defaults group=<RGname>```

### Het aanmaken van een key vault
Het aanmaken van een key vault gaat via deze 2 commandos:

```
1) KVNAME=<kvname>$RANDOM

2) az keyvault create \
  --name $KVNAME \
  --enabled-for-template-deployment true 
  ```

Het eerste commando maakt een bash variable welke een string aanmaakt met de **kvname** en een random string. Voor **kvname** is het aan te raden een redelijk simpele naam te kiezen.
Het tweede commando maakt de key vault aan met als naam de **kvname** en willekeurige string. Dit is nodig gezien de unieke naam die een key vault nodig heeft.  

En het laatste stuk zorgt er voor dat de key vault secrets gelezen mogen worden door de Azure resource manager.  
De **kvname** moet worden genoteerd voor een latere stap.


### Het aanmaken van de secrets
Het aanmaken van de secrets gaat ook via de cli en heeft 4 inputs nodig:
- admin username
- admin password
- linux username
- linux password

Bij alle 4 de commandos geldt dat alleen de laatste value aangepast moet worden.
Het aanmaken van de password secrets gaat via:
```
az keyvault secret set \
  --vault-name $KVNAME \
  --name adminPassword \
  --value <password>
```
&
```
az keyvault secret set \
  --vault-name $KVNAME \
  --name linuxPassword \
  --value <password>
  ```

Het is hierbij aan te raden complexe wachtwoorden te gebruiken.

Het aanmaken van de admin username secret gaat via:

```
az keyvault secret set \
  --vault-name $KVNAME \
  --name adminUsername \
  --value <username>

```

 ```
az keyvault secret set \
  --vault-name $KVNAME \
  --name linuxUsername \
  --value <username>
 ```
  
  
Het belangrijkste hier is het kiezen voor usernames welke logisch zijn.


### Het aanmaken van een key pair

Om de connectie naar de webserver te beveiligen is het nodig om deze te voorzien van public key. Hiervoor is het nodig om een key pair aan te maken. Dit gaat via deze stappen:

Aanmaken van de key pair gaat via Bash:  
```ssh-keygen -t rsa -b 4096 -N <passphase> -f ssh_key ```

De passphrase is een wachtwoord om de sleutel extra te beveiligen en is aan te raden, niet verplicht.

Er worden 2 bestanden aangemaakt; van deze moet het ```ssh_key.pub``` bestand moet worden gelinkt aan het **ssh_key** parameter in het VMSS_module.bicep bestand. (deze staat bovenaan)  
Bij deployment wordt dit bestand gebruikt en aan de webserver VM gekoppeld.

### Het aanmaken van een ssl certificate
Dit is alleen nodig voor een productie omgeving.  
Om de webserver een ssl connectie te geven is het nodig om een certificaat te hebben. Hiervoor is het nodig om een domein c.q. website te registreren, een certificate request te doen aan een certificate authority en na goedkeuring het certificaat aan het domein of website met ssl connectie te koppelen. 

Echter, gezien dit een nogal dure oplossing is voor een testomgeving wordt er een tijdelijke self signed certificaat aangemaakt. Deze staat al in de map en hoeft voor de testomgeving niet te worden aangepast.
Bij een productie omgeving is dit wel het geval en worden de bovenstaande stappen gebruikt en dit certificaat aan het ssl_cert parameter gekoppeld. 


### Het bepalen van het IP adres waar vanaf de admin gaat inloggen.
Het is voor de security settings nodig om het IP adres van de locatie waarvan de admin inlogt op de admin VM te bepalen en deze te koppelen aan de **adminIP** parameter en daarmee de security regels.
Noteer deze voor een latere stap.

### Het bepalen van de subscription ID.

Het subscription ID is nodig om de key vault secrets op te vragen.
Dit kan via de cli met ```az account subscription list```, maar ook via de portal, op de subscriptions page onder 'subscription ID'.  
Deze moet worden genoteerd voor een latere stap.

### Het aanpassen van de parameters

Voordat de deployment echt gestart kan worden is nu nog nodig om een 6-tal parameters aan te passen. Deze staan vanaf lijn 40.  
Het gaat om deze parameters:  
**adminIP**: deze moet het IP adres van de admin krijgen.  
**gatewaySubnetID**: deze moet de te gebruiken **subscriptionID** en **RGname** krijgen. In de huidige notering is dit genoteerd met duidelijke tags.  
De vault secrets welke alle 4 de te gebruiken **subscriptionID**, **RGname** en **kvname** krijgen. In de huidige notering is dit genoteerd met duidelijke tags.

# Stap 2: deployment.
Voor de deployment van de IaC app is het na het doorlopen van de pre-deployment stappen alleen nodig om het commando te gebruiken: 

```az deployment group create -f main.bicep --parameters main.parameters.bicepparam```   

In een aantal minuten wordt de gehele app deployed. 


# Stap 3: post deployment

Na deployment is het nodig om een aantal stappen te doorlopen:
1) Het inloggen op de Azure portal
2) Het controleren van de resources die gedeployed zijn.
3) Het selecteren van, en inloggen op de admin server via RDP
4) Het kopiëren van de aangemaakte ssh key naar de admin server (dit kan simpelweg via een copy and paste)
5) Het testen van de ssh connectie tussen de admin server en de webserver VMs
6) Het controleren van de instellingen van de apache2 webserver en het aanpassen van de standaard pagina en andere nodige settings

