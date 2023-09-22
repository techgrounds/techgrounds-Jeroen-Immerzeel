//keyvault module
param keyvaultName string
param location string

@secure()
param linuxPassword string

@secure()
param linuxUser string

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' ={
  name: keyvaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'de60b253-74bd-4365-b598-b9e55a2b208d'
  }
}
/*
resource linuxPass 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: linuxPassword
  properties: {
    attributes:{
      enabled:true
    }
    contentType:linuxPassword
    value:'q3?1fn0t=7ru3' 
  }
}

resource linuxUsername 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: linuxUser
  properties: {
    value:'jeroen'
  }
}*/
