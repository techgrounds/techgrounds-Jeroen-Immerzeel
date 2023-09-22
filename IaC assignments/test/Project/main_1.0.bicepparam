using './main_1.0.bicep'

param location = 'GermanyWestCentral'
param environmentType = 'dev'
param webserverSubnetName = 'webserverSubnet'
param webserverSubnetPrefix = '10.20.20.0/24'
param webserverVnetName = 'vnet-webserv'
param webserverVnetPrefix = '10.20.0.0/16'
param managementSubnetName = 'managementSubnet'
param managementVnetName = 'vnet-mngt'
param managementVnetPrefix = '10.10.0.0/16'
param managementSubnetPrefix = '10.10.10.0/24'
param VM_size = 'Standard_B1s'
param windowsName = 'adminServer'
param linuxName = 'LinuxWebserver'
param webserverName = 'webserverVM'
param managementName = 'adminVM'
param adminPassword = az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'adminPassword')
param linuxPassword = az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'linuxPassword')
param linuxUsername = getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'linuxUsername')
param adminUsername= az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'adminUsername')
param vaultName = 'testvault-jjoijk1'
param backupPolicyName = 'workingPolicy-ggyh'
param scheduleRunTimes = '2023-09-15T12:30:00Z'
param adminIP = '77.192.85.197'

