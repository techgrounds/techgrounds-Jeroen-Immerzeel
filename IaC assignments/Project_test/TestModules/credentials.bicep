
resource adminPassword 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'secrets/adminPassword'
  properties: {
     contentType:'adminPassword'
    value: 'q3?1fn0t=7ru3'
  }
}

resource linuxPassword 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'secrets/linuxPassword'
  properties: {
     contentType:'linuxPassword'
    value: 'q3?1fn0t=7ru3'
  }
}

resource adminUser 'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'secrets/adminUsername'
  properties: {
    contentType: 'adminUsername'
    value: 'aloise'
  }
}

resource linuxUser  'Microsoft.KeyVault/vaults/secrets@2023-02-01' ={
  name: 'secrets/linuxUsername'
  properties: {
    contentType:'linuxUsername'
    value:'jeroen'
  }
}
