@description('The Azure region into which the resources should eb deployed.')
param location string

@description('The name of the App Service app')
param appServiceAppName string


@description('The name of the App Service app.')
param appServicePlanName string

@description('The name of the App Servicee plan SKU.')
param appServicePlanSkuName string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' ={
  name: appServicePlanName
  location: location
  sku: {
    name:appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-09-01' ={
  name:  appServiceAppName
  location: location
  properties:{
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

@description('The default name of the App Service app.')
output appServiceHostName string = appServiceApp.properties.defaultHostName
