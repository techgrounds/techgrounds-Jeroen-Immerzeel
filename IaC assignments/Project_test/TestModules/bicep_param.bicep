//Resource group location
@description('The location of the resource group.')
param location string = 'germanywestcentral'

//Storage Account
@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'

@allowed ([
  'dev'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'


//Management Vnet parameters
@description('The name of the management vnet.')
param managementVnetName string = 'vnet-mngt'

//Management credentials
@description('The administrator password')
@secure()
param adminPassword string 

@description('The administrator username')
param adminUsername string


//webserver Vnet parameters
@description('The name of the webserver Vnet.')
param webserverVnetName string = 'vnet-webserv'

//Webserver Credentials
@description('The username for the Linux based webserver VM.')
param linuxUser string 
@secure()
@description('The password for the Linux based webserver VM')
param linuxPassword string


//Key Vault
@description('The name of the keyvault.')
param keyvault_name string = 'key_vault_jiutvn'
@description('The name of the endpointPolicy.')
param endpointPolicyName string = 'endpointpolicy-${uniqueString(resourceGroup().id)}'
