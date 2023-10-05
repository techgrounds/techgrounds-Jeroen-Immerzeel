//Storage account
@description('The locaton of the resource group')
param location string 

@description('The enviroment for the app; development or production')
@allowed ([
  'dev'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('The name of the storage account.')
@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' ={
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties:{
    accessTier:'Hot'
    allowBlobPublicAccess:true
    allowSharedKeyAccess:true
    publicNetworkAccess:'Enabled'
    supportsHttpsTrafficOnly:true

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
