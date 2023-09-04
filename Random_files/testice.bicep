@description('The Azure region into which the resources should be deployed')
param location string

@secure()
@description('The daministrator login username for the SQL server')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server')
param sqlServerAdministratorLogingPassword string

@description('The name and tier of the SQL database SKU')
param sqlDatabaseSku object = {
  name: 'Standard'
  tier: 'Standard'
}

var sqlServerName = 'teddy${location}${uniqueString(resourceGroup().id)}'
var sqlDatabaseName = 'Teddybear'

resource sqlServer 'Microsoft.Sql/servers@2022-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLogingPassword
  }
}
resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-11-01-preview'= {
  name: sqlDatabaseName
  location: location
  parent: sqlServer
  sku: sqlDatabaseSku
}

@description('The name of the enviroment. This must be Development or Production')
@allowed([
  'Development'
  'Production'
])
param environmentName string = 'Development'

@description('The name of the audit storage account SKU')
param auditStorageAccountSkuName string = 'Standard_LRS'

var auditingEnabled = environmentName == 'Production'
var AuditStorageAccountName = take('bearaudit${location}${uniqueString(resourceGroup().id)}', 24)


resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = if (auditingEnabled) {
  name: AuditStorageAccountName
  location: location
  sku: {
    name: auditStorageAccountSkuName
  }
  kind: 'StorageV2'
}

resource sqlServerAudit 'Microsoft.Sql/servers/auditingSettings@2022-11-01-preview' = if (auditingEnabled) {
  parent:sqlServer
  name:'default'
  properties: {
    state: 'Enabled'
    storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
    storageAccountAccessKey: environmentName == 'Production' ? listKeys(auditStorageAccount.id, auditStorageAccount.apiVersion).keys[0].value : ''
  }
}
