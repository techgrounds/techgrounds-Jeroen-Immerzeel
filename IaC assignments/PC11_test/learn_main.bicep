@description('The azure region into which the resources should be deployed.')
param location string = 'westus3'

@description('The name of teh App Service app.')
param appServiceAppName string = 'toy-${uniqueString(resourceGroup().id)}'

@description('The name of the App Service plan SKU')
param appServiceSkuName string = 'F1'

@description('Indicates whether a CDN should be deployed.')
param deployCdn bool = true

var appServicePlanName = 'toy-product-launch-plan'

module app 'learn_modules/learn_app.bicep' = {
  name: 'toy-launch-app'
  params: {
    appServiceAppName: appServiceAppName
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServiceSkuName
    location: location
  }
}

module cdn 'learn_modules/learn_cdn.bicep' = if (deployCdn) {
  name: 'toy-launch-cdn'
  params: {
    httpsOnly: true
    originHostName: app.outputs.appServiceHostName
  }
}


@description('The host name to use to access sthe website.')
output websiteHostName string = deployCdn ? cdn.outputs.endpointHostName : app.outputs.appServiceHostName
