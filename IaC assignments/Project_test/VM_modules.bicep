@description('The location of the resource group.')
param location string = 'germanywestcentral'


//NSG
@description('The name of the Network Security Group')
param NSG_name string = 'NSG-${uniqueString(resourceGroup().id)}' 

@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'

@allowed ([
  'dev'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource webservervnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing ={
  name: 'webservvnet'
}

resource managementvnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing ={
  name: 'managementvnet'
}

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
          {
            id: '${managementvnet.id}/subnets/managementsubnet'
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

//Network security group

resource NSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: NSG_name
  location:location
  dependsOn:[
    managementvnet
    webservervnet
  ]
  
  properties:{
    securityRules: [
    {
      name:'AllowSSH'
      properties:{
        access:'Allow'
        direction:'Inbound'
        priority: 300
        protocol:'TCP'
        destinationPortRange:'22'
        destinationAddressPrefix: '*'
        destinationAddressPrefixes:[]
        sourceAddressPrefixes: []
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
      }
    }
    {
      name:'AllowRDP'
      properties:{
        access: 'Allow'
        direction: 'Inbound'
        priority: 320
        protocol: 'TCP'
        destinationPortRange:'3389'
        destinationAddressPrefix: '*'
        destinationAddressPrefixes:[]
        sourceAddressPrefixes: []
        sourceAddressPrefix: '*'
        sourcePortRange: '*' 
      }
    }
    {
      name:'allowHTTPS'
      properties:{
        access:'Allow'
        direction: 'Inbound'
        priority: 330
        protocol: 'Tcp'
        destinationPortRange:'443'
        destinationAddressPrefix: '*'
        destinationAddressPrefixes:[]
        sourceAddressPrefixes: []
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
      }
    }
    {
      name:'allowHTTP'
      properties:{
        access: 'Allow'
        direction: 'Inbound'
        priority: 350
        protocol: 'Tcp'
        destinationPortRange:'80'
        destinationAddressPrefix: '*'
        destinationAddressPrefixes:[]
        sourceAddressPrefixes: []
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
      }
    }
    ]
  }
}
