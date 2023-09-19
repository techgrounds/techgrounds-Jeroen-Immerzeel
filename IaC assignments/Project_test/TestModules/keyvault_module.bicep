@description('The location of the resource group.')
param location string = 'germanywestcentral'


@description('The name of the keyvault.')
param keyvault_name string = 'key_vault_jiutvn'//${uniqueString(resourceGroup().id)}'

@description('The Uri of the Keyvault.')
param keyvaultUri string = '${keyvault_name}.enviroment()'

param objectId string = '17e2b6ee-f761-4bc6-a5a3-3c7a7b6080c5'



//recovery vault
@description('The name of the Backup and recovery Vault')
param vaultName string = 'backupVault-${uniqueString(resourceGroup().id)}'



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


