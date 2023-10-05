using './main.bicep'

param location = 'GermanyWestCentral'
param environmentType = 'dev'
param VMSS_name = 'scaleset'
param VMSS_Subnet = 'VMSS-Subnet' 
param VMSSnetSubnetPrefix = '10.20.0.0/24'
param VMSS_vnet = 'VMSS_Vnet'
param VMSSVnetPrefix = '10.20.0.0/16'
param VMSS_subnetID = 'VMSS_subnetID'
param VM_size = 'Standard_B1s'
param NSG_name = 'NSG'

param gateway_name = 'mainGateway'
param gatewaySubnetName = 'gateway_Subnet'
param gatewayAddressPrefix = '10.20.30.0/27' 

param linuxName = 'LinuxWebserver'


param managementVnetName = 'mngt-Vnet' 
param managementVnetPrefix = '10.10.0.0/16'
param managementSubnetPrefix = '10.10.10.0/24'
param managementName = 'admin-VM'
param windowsName = 'adminServer'
param managementSubnetName = 'managementSubnet'
param adminVM_size = 'Standard_B2s'


param vnet_module = 'vnet_module'
param VMSSModule = 'VMSS_module'
param storageModule = 'storageSQL_module'
param vaultName = 'recoveryServicesVault2'
param backupPolicyName = 'enhanced-policy-cloud11'
param scheduleRunTimes = '2023-09-15T12:30:00Z'
param backupModule = 'backup_module'




//Deze parameters moeten worden aangepast tijdens deployment:

//dit is de parameter voor het IP adres van de admin, deze moet worden aangepast met als syntax: '10 10.10.10'
param adminIP = '77.162.85.197'

// de gegevens van de secrets met als onderdelen die moeten worden aangepast: <subscriptionID>, <RGname>, <vault name>.
/*
param linuxUsername = az.getSecret('<subscriptionID>', '<RGname>', '<kvname>', 'linuxUsername')
param linuxPassword = az.getSecret('<subscriptionID>', '<RGname>', '<kvname>', 'linuxPassword')
param adminUsername = az.getSecret('<subscriptionID>', '<RGname>', '<kvname>', 'adminUsername')
param adminPassword = az.getSecret('<subscriptionID>', '<RGname>', '<kvname>', 'adminPassword')
*/
param linuxUsername = az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'linuxUsername')
param linuxPassword = az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'linuxPassword')
param adminUsername = az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'adminUsername')
param adminPassword = az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'test', 'testvault-jjoijk1', 'adminPassword')

// de volgende 2 onderdelen: <subscriptionID> <RGname> '/subscriptions/<subscriptionID>/resourcegroups/<RGname>/providers/microsoft.network/virtualnetworks/vmss_vnet/subnets/gateway_subnet'
param gatewaySubnetID = '/subscriptions/180a468a-5df4-41f7-a716-a1ff81e87bb7/resourcegroups/test/providers/microsoft.network/virtualnetworks/vmss_vnet/subnets/gateway_subnet'
