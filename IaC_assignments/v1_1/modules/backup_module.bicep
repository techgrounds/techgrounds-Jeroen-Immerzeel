
@description('The locaton of the resource group')
param location string = resourceGroup().location


@description('The name of the backup vault')
param vaultName string

@description('The name of the backup policy.')
param backupPolicyName string

@description('The runtimes for the backup schedule.')
param scheduleRunTimes string 

param managementName string
param existingVirtualMachinesResourceGroup string = resourceGroup().name

var backupFabric = 'Azure'
/*var protectionContainer = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name};${managementName}'
var protectedItem = 'vm;iaasvmcontainerv2;${resourceGroup().name};${managementName}'*/

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
        softDeleteRetentionPeriodInDays: 7
      }
    }
  }
}

param isNewPolicy bool = true
//Backup Resources
resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-04-01' = if (isNewPolicy)  {
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


var v2VmContainer = 'iaasvmcontainer;iaasvmcontainerv2;'
var v2Vm = 'vm;iaasvmcontainerv2;'
param existingVirtualMachines array = [ managementName ]

resource protectedItems 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-01-01' = [for item in existingVirtualMachines: {
  name: '${vaultName}/${backupFabric}/${v2VmContainer}${existingVirtualMachinesResourceGroup};${item}/${v2Vm}${existingVirtualMachinesResourceGroup};${item}'
  location: location
  properties: {
    protectedItemType: 'Microsoft.ClassicCompute/virtualMachines'
    policyId:backupPolicy.id
    sourceResourceId: resourceId(subscription().subscriptionId, existingVirtualMachinesResourceGroup, 'Microsoft.Compute/virtualMachines', '${item}')
    
  }
}]

