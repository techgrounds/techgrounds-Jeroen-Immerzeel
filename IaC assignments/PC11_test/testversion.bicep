
//Dit is de werkende versie van de onderdelen Vnets, Keyvault en storage
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




@description('The IDs for the Virtual Networks')
param webServ_vnet_id string = '/subscriptions/180a468a-5df4-41f7-a716-a1ff81e87bb7/resourceGroups/dev/providers/Microsoft.Network/virtualNetworks/vnet-webserv'
param mngt_vnet_id string = '/subscriptions/180a468a-5df4-41f7-a716-a1ff81e87bb7/resourceGroups/dev/providers/Microsoft.Network/virtualNetworks/vnet-mngt'

@description('The name of the keyvault.')
param keyvault_name string = 'pc11vault'

resource stg 'Microsoft.Storage/storageAccounts@2023-01-01' = {
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
            id: '${webServ_vnet_id}/subnets/webserversubnet'
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
//service endpoint keyvault
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
              service: 'Microsoft.Keyvault'
            locations: ['*']
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
            id: mngt_vnet_id
          }
          useRemoteGateways:false
          peeringSyncLevel:'FullyInSync'
        
        }

      }
    ]  
  }
}


//service endpoint keyvault
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
              service: 'Microsoft.Keyvault'

            }

          ]
        }
      }
    ]
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
      id: '${webServ_vnet_id}subnets/webserversubnet'
      ignoreMissingVnetServiceEndpoint: false
     }
     {
      id: '${mngt_vnet_id}/subnets/managementsubnet'
      ignoreMissingVnetServiceEndpoint: false
     }
    ]
  }
    vaultUri:'https://${keyvault_name}.vault.azure.net/'
    tenantId: subscription().tenantId
    accessPolicies:[]
    enabledForDeployment:true
    enabledForDiskEncryption:true
    enabledForTemplateDeployment:true
    enablePurgeProtection:true
    enableRbacAuthorization:true
    softDeleteRetentionInDays: 90
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'enabled'

  }
}
