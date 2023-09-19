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

//Modules

module VM_Module 'VM_module.bicep'= {
  name: 'vm_module'
  params: {
    adminPassword: adminPassword
    adminUsername: adminUsername
    location:location
    linuxPassword: linuxPassword
    linuxUser: linuxUser
  }
}

module keyvault_module 'keyvault_module.bicep' ={
  name: keyvault_name
  params:{
    location:location
    keyvault_name:'kv4ult${uniqueString(resourceGroup().id)}'
  }
}



 //Refferences
 resource webservervnet 'Microsoft.Network/virtualNetworks@2023-04-01' existing ={
  name: webserverVnetName 
 }


 resource managementvnet 'Microsoft.Network/virtualNetworks@2023-04-01' existing ={
  name: managementVnetName
 }


//Storage Account

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



//Endpoint Policy

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
