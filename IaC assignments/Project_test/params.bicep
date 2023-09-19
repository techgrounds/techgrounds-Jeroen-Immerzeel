
@description('The location of the resource group.')
param location string = 'germanywestcentral'

@maxLength(24)
param storageAccountName string = 'pc11storage${uniqueString(resourceGroup().id)}'

@allowed ([
  'dev'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('The name of the Network Security Group')
param NSG_name string = 'NSG-${uniqueString(resourceGroup().id)}' 

//Key vault
@description('The name of the keyvault.')
param keyvault_name string = 'bymy1${uniqueString(resourceGroup().id)}'

@description('The name of the endpointPolicy.')
param endpointPolicyName string = 'endpointpolicy-${uniqueString(resourceGroup().id)}'


@description('The Uri of the Keyvault.')
param keyvaultUri string = '${keyvault_name}.enviroment()'


@description('The name of the Backup and recovery Vault')
param vaultName string = 'backupVault-${uniqueString(resourceGroup().id)}'

@description('The name of the backup policy')
param backupPolicyName string = '${vaultName}-policy'

var scheduleRunTimes = [
  '2023-09-05T23:00:00Z'
]


@description('The name of the webserversubnet.')
param webserverSubnetName string = 'webserverSubnet'

@description('The subnet prefix for the webserver Subnet')
param webserverSubnetPrefix string = '10.20.20.0/24'

@description('The name of the webserver Vnet.')
param webserverVnetName string = 'vnet-webserv'

@description('The name and IP prefix of the webserver Vnet.')
param webserverVnetPrefix string = '10.20.0.0/16'


@description('The size of the VMs')
param vm_size string = 'Standard_B1s'


@description('The Linux computername.')
param linuxName string = 'LinuxWebserver'

@description('The name of the VMs')
param vmName string = 'VM'
@description('The name of the management subnet.')
param managementSubnetName string = 'managementSubnet'

@description('The name and IP prefix of the management vnet.')
param managementVnetName string = 'vnet-mngt'

@description('The IP prefix of the management vnet.')
param managementVnetPrefix string = '10.10.0.0/16'

@description('The IP prefix of the management subnet.')
param managementSubnetPrefix string = '10.10.10.0/24'


@description('The administrator password')
@secure()
param adminPassword string = ''

@description('The administrator username')
@secure()
param adminUsername string = ''




