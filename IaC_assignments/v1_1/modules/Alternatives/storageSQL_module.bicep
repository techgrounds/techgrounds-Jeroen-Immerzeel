//Storage account
@description('The locaton of the resource group')
param location string = 'GermanyWestCentral'

@description('The enviroment for the app; development or production')
@allowed ([
  'dev'
  'prod'
])
param environmentType string = 'dev'
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('The name of the storage account.')
@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'


@description('The administrator password for the SQL server')
@secure()
param SQLAdminPassword string = 'th1sIsaP4$$w0rdString'

@secure()
@description('The administrator username for the SQL server')
param SQLAdminUsername string = 'aloise'

param VMSS_Subnet string

//mangement Vnet

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
  resource tableServices 'tableServices@2023-01-01'= {
    name: 'default'
    properties: {
      
    }
  }
  
}


param SQL_name string
resource SQL_instance 'Microsoft.Sql/managedInstances@2023-02-01-preview' ={
  name: SQL_name
  location: location
  sku:{
    name: 'GP_Gen5'
  }
  properties:{
    administratorLogin:SQLAdminUsername
    administratorLoginPassword:SQLAdminPassword
    minimalTlsVersion: '1.2'
    subnetId: VMSS_Subnet
    timezoneId: 'UTC'
    zoneRedundant: true
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    storageSizeInGB: 30

  }
}


