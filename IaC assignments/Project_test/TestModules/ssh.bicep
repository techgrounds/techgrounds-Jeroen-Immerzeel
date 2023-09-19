//main
@description('The location of the resource group.')
param location string = 'germanywestcentral'

@description('The Uri of the Keyvault.')
param keyvaultUri string = '${keyvault_name}.enviroment()'

@description('The name of the keyvault.')
param keyvault_name string = 'Vault13sept-2'

param objectId string = '17e2b6ee-f761-4bc6-a5a3-3c7a7b6080c5'



resource keyvault 'Microsoft.KeyVault/vaults@2023-02-01' =  {
  name: keyvault_name
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
  networkAcls:{
    ipRules:[
    
    ]
    bypass: 'AzureServices'
    defaultAction:'Allow'
  }
    accessPolicies:[
      {
        objectId: objectId
        permissions: { 
           keys:[
            'all'
           ]
           certificates:[
            'all'
           ]
           secrets:[
            'all'
           ]
           storage:[
            'all'
           ]
        }
        tenantId: tenant().tenantId
      }
    ]
    vaultUri: keyvaultUri
    tenantId: subscription().tenantId
    enabledForDeployment:true
    enabledForDiskEncryption:false
    enabledForTemplateDeployment:true
    enablePurgeProtection:true
    enableRbacAuthorization:false
    softDeleteRetentionInDays: 7
    enableSoftDelete:true
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'enabled'
    
  }
}




//secrets

resource adminPass 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'adminPassword'
  parent: keyvault
  properties: {
     contentType:'adminPassword'
    value: 'q3?1fn0t=7ru3'
  }
}

resource linuxPassword 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'linuxPassword'
  parent:keyvault
  properties: {
     contentType:'linuxPassword'
    value: 'q3?1fn0t=7ru3'
  }
}

resource adminUser 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'adminUsername'
  parent:keyvault
  properties: {
    contentType: 'adminUsername'
    value: 'aloise'
  }
}

resource linuxUser 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'linuxUsername'
  parent:keyvault
  properties: {
    contentType:'linuxUsername'
    value:'jeroen'
  }
}

