//This is the main template. This contains the resources definitions of the Storage Account and Network Security Group.


//parameters
//ganeral

@description('The locaton of the resource group')
param location string = resourceGroup().location

param environmentType string
// Administration VM 

@description('The administrator password')
@secure()
param adminPassword string

@secure()
@description('The administrator username')
param adminUsername string

@description('The name of the management VM')
param managementName string

@description('The name of the Windows based management server.')
param windowsName string

@description('The size of the VM used for the administration server.')
param adminVM_size string

//backup

@description('The name of the backup policy.')
param backupPolicyName string

@description('The runtimes for the backup schedule.')
param scheduleRunTimes string 

@description('The name of the backup vault')
param vaultName string

@description('The resource group in which the VMs are placed.')
param existingVirtualMachinesResourceGroup string = resourceGroup().name


//Networking

@description('The size of the webserver VM.')
param VM_size string

@description('The name of the Network Security Group')
param NSG_name string


@description('The name of the webserversubnet.')
param VMSS_Subnet string 

@description('The ID of the VMSS subnet')
param VMSS_subnetID string

@description('The subnet prefix for the webserver Subnet')
param VMSSnetSubnetPrefix string

@description('The name of the VMSS Vnet.')
param VMSS_vnet string

@description('The IP prefix of the webserver Vnet.')
param VMSSVnetPrefix string

@description('The ID for the gateway Subnet')
param gatewaySubnetID string

@description('The name of the management vnet.')
param managementVnetName string


@description('The name of the subnet for the Gateway.')
param gatewaySubnetName string

@description('The prefix of the Gateway Subnet.')
param gatewayAddressPrefix string

@description('The prefix of the management Vnet.')
param managementVnetPrefix string

@description('The prefeix of the management Subnet.')
param managementSubnetPrefix string

@description('The name of the management Subnet.')
param managementSubnetName string

//VMSS and Gateway

@description('The name of the VMSS VMs')
param VMSS_name string

@description('The Linux computername.')
param linuxName string 

@secure()
@description('The username for the webservers.')
param linuxUsername string 

@secure()
@description('The password for the webservers')
param linuxPassword string

@description('The name of the application gateway')
param gateway_name string


//NSG
@description('The IP address of the administrators computer.')
param adminIP string

//storage
@description('The name of the storage account.')
@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'


//module names
param backupModule string
param storageModule string
param VMSSModule string
param vnet_module string


//modules

module storage 'modules/storageNoSQL_module.bicep' = {
  name: storageModule
  params: {
    environmentType: environmentType
    location: location
    storageAccountName:storageAccountName

  }
}

module vnets 'modules/vnets.bicep' = {
  name: vnet_module
  params: {
    adminIP: adminIP
    gatewayAddressPrefix: gatewayAddressPrefix
    gatewaySubnetID: gatewaySubnetID
    gatewaySubnetName: gatewaySubnetName
    location: location
    managementSubnetName: managementSubnetName
    managementSubnetPrefix: managementSubnetPrefix
    managementVnetName: managementVnetName
    managementVnetPrefix: managementVnetPrefix
    NSG_name: NSG_name
    VMSS_Subnet: VMSS_Subnet
    VMSS_subnetID: VMSS_subnetID
    VMSS_vnet: VMSS_vnet
    VMSSnetSubnetPrefix: VMSSnetSubnetPrefix 
    VMSSVnetPrefix: VMSSVnetPrefix
    adminPassword:adminPassword
    adminUsername:adminUsername
    adminVM_size:adminVM_size
    managementName:managementName
    windowsName:windowsName
  }
}


module VMSS 'modules/VMSS_module.bicep' = {
  name: VMSSModule
  params: {
    location: location
    gateway_name: gateway_name
    VMSS_vnet: VMSS_vnet
    VMSS_Subnet: VMSS_Subnet
    VMSS_name: VMSS_name
    VM_size: VM_size
    linuxName: linuxName
    linuxPassword: linuxPassword
    linuxUsername: linuxUsername
    //ssh_key: ssh_key
  }
}



module backup 'modules/backup_module.bicep'= {
  name: backupModule
  params: {
    backupPolicyName: backupPolicyName
    location: location
    scheduleRunTimes: scheduleRunTimes
    vaultName: vaultName
    existingVirtualMachinesResourceGroup: existingVirtualMachinesResourceGroup
    //existingVirtualMachines: existingVirtualMachines 
    managementName:managementName
  }
}

