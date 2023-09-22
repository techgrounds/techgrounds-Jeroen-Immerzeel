using './MVP_build.bicep'

param location = 'GermanyWestCentral'
param NSG_name = 'NSG'
param adminVM_size = 'Standard_B1s'
param linuxName = 'Webserver'
param linuxUser = getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'app-RG', 'app-vault-19sept', 'linuxUser')
param linuxPassword = az.getSecret('180a468a-5df4-41f7-a716-a1ff81e87bb7', 'app-RG', 'app-vault-19sept', 'linuxPassword')
param vNetPrefix = '10.10.0.0/16'
param SubnetPrefix = '10.10.0.0/24'
