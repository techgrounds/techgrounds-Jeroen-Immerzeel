using './main_1.0.bicep'

param location = ''
param environmentType = 'dev'
param storageAccountName = 'storage${uniqueString(resourceGroup().id)}'
param webserverSubnetName = ''
param webserverSubnetPrefix = ''
param webserverVnetName = ''
param webserverVnetPrefix = ''
param managementSubnetName = ''
param managementVnetName = ''
param managementVnetPrefix = ''
param managementSubnetPrefix = ''
param adminVM_size = 'Standard_B2s'
param webserverVM_size = 'Standard_B1s'
param windowsName = ''
param linuxName = ''
param webserverName = ''
param managementName = ''
param adminPassword = ''
param linuxPassword = ''
param linuxUser = ''
param adminUser = ''
param adminIP = '77.192.85.197'
param keyvaultName = ''
param vaultName = ''
param backupPolicyName = ''
param scheduleRunTimes = ''
param existingVirtualMachines = [
  webserverName
  managementName
]
param existingVirtualMachinesResourceGroup = resourceGroup().name

