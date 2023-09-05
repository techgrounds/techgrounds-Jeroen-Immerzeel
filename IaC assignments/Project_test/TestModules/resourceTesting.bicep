resource backupVault 'Microsoft.RecoveryServices/vaults@2023-04-01'={
  name: 'vault'
  location:'germanywestcentral'
  sku:{
    name: 'RS0'
    tier:'Standard'
  }
  properties:{

    publicNetworkAccess:'Enabled'
    securitySettings:{
      immutabilitySettings:{
        state:'Disabled'
      }
    }
  }
}

resource backUpPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-04-01' = {
  name: 'policy'
  location:'germanywestcentral'
  parent:backupVault
  properties:{
    backupManagementType: 'AzureIaasVM'
    policyType:'V2'
    instantRPDetails:{}
    schedulePolicy:{
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency:'Daily'
      dailySchedule:{
        scheduleRunTimes:[
          '2023-09-06-T00:00:00Z'
        ]
      }
    }
    retentionPolicy:{
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule:{
        retentionTimes:[
          '2023-09-06-T00:00:00Z'
        ]
        retentionDuration: {
          count:7
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 6
    timeZone: 'Central European Time'
    protectedItemsCount: 0
  }  
}
