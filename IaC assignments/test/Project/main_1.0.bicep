//This is the main template. This contains the resources definitions of the Storage Account and Network Security Group.

//parameters

//General Resource Parameters
@description('The locaton of the resource group')
param location string 


@description('The enviroment for the app; development or production')
@allowed ([
  'dev'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('The name of the storage account.')
@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'

//Vnets
@description('The name of the webserversubnet.')
param webserverSubnetName string 

@description('The subnet prefix for the webserver Subnet')
param webserverSubnetPrefix string

@description('The name of the webserver Vnet.')
param webserverVnetName string

@description('The IP prefix of the webserver Vnet.')
param webserverVnetPrefix string

@description('The name of the management subnet.')
param managementSubnetName string

@description('The name of the management vnet.')
param managementVnetName string

@description('The IP prefix of the management vnet.')
param managementVnetPrefix string

@description('The IP prefix of the management subnet.')
param managementSubnetPrefix string 

//VMs
@description('The size of the VM, ordered by compute power and price from lowest to highest: B1s, B1ms, B2s.')
@allowed( [
  'Standard_B1s'
  'Standard_B1ms'
  'Standard_B2s'
])
param VM_size string
 
@description('The name of the Windows based management server.')
param windowsName string

@description('The Linux computername.')
param linuxName string 

@description('The name of the webserver VM')
param webserverName string

@description('The name of the management VM')
param managementName string

@secure()
param adminPassword string

@secure()
param linuxPassword string
        
@secure()
param linuxUsername string

@secure()
param adminUsername string 

@description('The IP address of the administrators computer.')
param adminIP string = '77.192.85.197'

@description('The name of the backup vault')
param vaultName string

@description('The name of the backup policy.')
param backupPolicyName string

@description('The runtimes for the backup schedule.')
param scheduleRunTimes string 

@description('Array of Azure virtual machines.')
param existingVirtualMachines array = [
  webserverName
  managementName
]
param existingVirtualMachinesResourceGroup string = resourceGroup().name

var backupFabric = 'Azure'
var v2VmContainer = 'iaasvmcontainer;iaasvmcontainerv2;'
var v2Vm = 'vm;iaasvmcontainerv2;'

//modules
module VM  'modules/network_module.bicep' = {
  name: 'main_deployment'
  params: {
    location:location
    VM_size:VM_size
    windowsName:windowsName
    linuxName:linuxName
    adminIP:adminIP
    adminPassword:adminPassword 
    adminUsername:adminUsername
    linuxPassword:linuxPassword
    linuxUsername:linuxUsername
    managementSubnetName:managementSubnetName
    managementSubnetPrefix:managementSubnetPrefix
    managementVnetName:managementVnetName
    managementVnetPrefix:managementVnetPrefix
    webserverSubnetName:webserverSubnetName
    webserverSubnetPrefix:webserverSubnetPrefix
    webserverVnetName:webserverVnetName
    webserverVnetPrefix:webserverVnetPrefix
    managementName:managementName
    webserverName:webserverName
  }
}


//resources
//Storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' ={
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties:{
    accessTier:'Hot'
    allowBlobPublicAccess:true
    allowSharedKeyAccess:true
    publicNetworkAccess:'Enabled'
    supportsHttpsTrafficOnly:true

  }
  resource blobServices 'blobServices@2023-01-01' = {
    name: 'default'
    dependsOn:[
      
    ]
    properties:{
      changeFeed:{
        enabled:true
      }
      containerDeleteRetentionPolicy:{
        enabled:true
        days: 7
      }
      deleteRetentionPolicy:{
        allowPermanentDelete:false
        days: 7
        enabled:true
      }
  
      isVersioningEnabled:true
  
    }
  }

  resource fileServices 'fileServices@2023-01-01' = {
    name: 'default'
    properties:{
      shareDeleteRetentionPolicy: {
        allowPermanentDelete:false
        days:7
        enabled:true
      }
        
    }
  }
  
}



resource recoveryVault  'Microsoft.RecoveryServices/vaults@2023-04-01' ={
  name: vaultName
  location: location
  sku:{
    name:'Standard'
  }
  properties:{
    publicNetworkAccess:'Enabled'
    restoreSettings:{
      crossSubscriptionRestoreSettings:{
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
    securitySettings:{
      immutabilitySettings:{
        state:'Disabled'
      }
      softDeleteSettings:{
        softDeleteState:'Enabled'
        softDeleteRetentionPeriodInDays:14
      }
    }
  }
}

//Backup Resources
resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-04-01' ={
  name: backupPolicyName
  location:location
  parent:recoveryVault
  properties:{
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 5
    policyType:'V2'
    retentionPolicy:{
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule:{
        retentionDuration:{
          count: 7
          durationType: 'Days'
        }
        retentionTimes:[
          scheduleRunTimes
        ]
      }
    }
    
    schedulePolicy:{
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      dailySchedule:{
        scheduleRunTimes:[
          scheduleRunTimes
        ]
      }
      scheduleRunFrequency:'Daily'
    }
    tieringPolicy:{}
    timeZone:'UTC'
  } 

}

resource protectedItems 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-01-01' = [for item in existingVirtualMachines: {
  name: '${vaultName}/${backupFabric}/${v2VmContainer}${existingVirtualMachinesResourceGroup};${item}/${v2Vm}${existingVirtualMachinesResourceGroup};${item}'
  location: location
  dependsOn:[
    webVM
    managementVM

  ]
  properties: {
    protectedItemType: 'Microsoft.Compute/virtualMachines'
    policyId:backupPolicy.id
    sourceResourceId: resourceId(subscription().subscriptionId, existingVirtualMachinesResourceGroup, 'Microsoft.Compute/virtualMachines', '${item}')
    
  }
}]

resource managementVM 'Microsoft.Compute/virtualMachines@2023-03-01' existing ={
  name: managementName
}

resource webVM 'Microsoft.Compute/virtualMachines@2023-03-01' existing ={
  name: webserverName
}

