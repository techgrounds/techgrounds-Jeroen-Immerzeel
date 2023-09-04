
/*Dit is de werkende versie van de onderdelen Vnets, Keyvault en storage
Nog toe te voegen:
NSGs, VMs, managed Ids
Ook resource group met naam 'production'

Modules:
Main template: Strorage + keyvault + managed IDs
Module network: Vnets, subnets
Module VMs: VMs, NSGs (dit omdat de nodige NSG rules voor de toegang tot VMs worden gebruikt)
*/
@description('The location of the resource group.')
param location string = 'germanywestcentral'

@maxLength(24)
param storageAccountName string = 'pc11storage${uniqueString(resourceGroup().id)}'


@allowed ([
  'dev'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'


@description('The name and IP prefix of the managenent vnet.')
param managementVnetName string = 'vnet-mngt'
param managementVnetPrefix string = '10.10.0.0/16'

@description('The name and IP prefix of the webserver Vnet.')
param webserverVnetName string = 'vnet-webserv'
param webserverVnetPrefix string = '10.20.0.0/16'

@description('The prefixes for the subnets.')
param managementSubnetName string = 'managementSubnet'
param webserverSubnetName string = 'webserverSubnet'
param managementSubnetPrefix string = '10.10.10.0/24'
param webserverSubnetPrefix string = '10.20.20.0/24'

@description('The name of the keyvault.')
param keyvault_name string = 'pc11vault'


@description('The Uri of the Keyvault.')
param keyvaultUri string = '${keyvault_name} enviroment()'

@allowed ([
  'dev'
  'prod'
])
var softdeletion = (environmentType == 'dev') ? false : true
var softDeleteInDays = (environmentType == 'dev') ? 7 : 90

@description('The name of the endpointPolicy.')
param endpointPolicyName string = 'endpointpolicy-${uniqueString(resourceGroup().id)}'

@description('The name of the endpoint definition')
param endpointDefinitionName string = 'endpointdefinition-${uniqueString(resourceGroup().id)}'





//StorageAccount
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name:  storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier:'Hot'
    defaultToOAuthAuthentication: false


    encryption:{
      keySource: 'Microsoft.Storage'
      services:{
        blob:{
          enabled:true
      
        }
        file:{
          enabled:true
        }
        queue:{
          enabled:true
        }
        table:{
          enabled:true
        }
      }
      requireInfrastructureEncryption:true
       
      }
      allowBlobPublicAccess:false
      routingPreference:{
        routingChoice:'MicrosoftRouting'
        publishMicrosoftEndpoints:true
      }
      publicNetworkAccess:'Disabled'
      minimumTlsVersion:'TLS1_2'
      supportsHttpsTrafficOnly:true
      isLocalUserEnabled:true
      networkAcls:{
        defaultAction: 'Allow'
        bypass: 'AzureServices'
        virtualNetworkRules:[
          {
            id: '${webservervnet.id}/subnets/webserversubnet'
            action: 'Allow'
            state:'Succeeded'
          }
        ]
        ipRules:[]
      }
      dnsEndpointType:'Standard'
      allowSharedKeyAccess:true

      
  }  



resource blobServices 'blobServices@2023-01-01' = {
  name: 'default'
  dependsOn:[
    
  ]
  properties:{
    changeFeed:{
      enabled:true
    }
    containerDeleteRetentionPolicy:{
      enabled:true
      days: 7
    }
    deleteRetentionPolicy:{
      allowPermanentDelete:false
      days: 7
      enabled:true
    }

    isVersioningEnabled:true

  }
}


resource fileServices 'fileServices@2023-01-01' = {
  name: 'default'
  properties:{
    shareDeleteRetentionPolicy: {
      allowPermanentDelete:false
      days:7
      enabled:true
    }
      
    }
}

}


//keyvault
resource pc11keyvault 'Microsoft.KeyVault/vaults@2023-02-01' =  {
  name: keyvault_name
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
  networkAcls:{
    ipRules:[]
    bypass: 'AzureServices'
    defaultAction:'Deny'
    virtualNetworkRules:[
     {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', webserverVnetName, webserverSubnetName)

      ignoreMissingVnetServiceEndpoint: false
     }
     {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', managementVnetName, managementSubnetName)
      ignoreMissingVnetServiceEndpoint: false
     }
    ]
  }

    vaultUri: keyvaultUri
    tenantId: subscription().tenantId
    accessPolicies:[]
    enabledForDeployment:true
    enabledForDiskEncryption:true
    enabledForTemplateDeployment:true
    enablePurgeProtection:softdeletion
    enableRbacAuthorization:false
    softDeleteRetentionInDays: softDeleteInDays
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'enabled'

  }
}



// Dit deel moet in een module
resource managementvnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: managementVnetName
  location: location
  properties:{
    addressSpace:{
      addressPrefixes: [
        managementVnetPrefix
      ]
    }
    subnets:[
      {
        name: managementSubnetName
        properties:{
          addressPrefix:managementSubnetPrefix
          serviceEndpoints:[
            {
              service: 'Microsoft.KeyVault'
              locations: ['*']
            }
            {
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
    ] 

    virtualNetworkPeerings:[
      {
        name: 'mngtToWebPeering'
        properties:{
          allowForwardedTraffic:false
          allowGatewayTransit:false
          allowVirtualNetworkAccess:true
          doNotVerifyRemoteGateways:false
          peeringState:'Connected'
          
          remoteAddressSpace:{
            addressPrefixes:[
              '10.20.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace:{
            addressPrefixes:[
             '10.20.0.0/16'
            ]
            
          }
          remoteVirtualNetwork:{
            id: webservervnet.id
          }
          useRemoteGateways:false
          peeringSyncLevel:'FullyInSync'
        
        }

      }
    ]  
  }
}



resource webservervnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: webserverVnetName
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        webserverVnetPrefix
      ]
    }
    subnets:[
      {
        name: webserverSubnetName
        properties:{
          addressPrefix: webserverSubnetPrefix
          serviceEndpoints:[
            {
              service: 'Microsoft.KeyVault'
              locations:['*']
            }
            {
              service: 'Microsoft.Storage'
              locations:[
                '*'
              ]
            }
            
          ]
        }
      }
    ]
  }
}


resource endpointPolicy 'Microsoft.Network/serviceEndpointPolicies@2023-04-01' ={
  name: endpointPolicyName
  location:location
  properties:{
    serviceEndpointPolicyDefinitions:[
      {
        id:storageAccount.id
        name:endpointPolicyName
        properties:{
          service:'Microsoft.Storage'
          serviceResources: [
            storageAccount.id
          ]
        }
      }
    ]

  }
}

