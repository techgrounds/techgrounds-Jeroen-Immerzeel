
@description('The location of the resource group.')
param location string = 'germanywestcentral'

@maxLength(24)
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'
@allowed ([
  'dev'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('The name of the management vnet.')
param managementVnetName string = 'vnet-mngt'

@description('The administrator password')
@secure()
param adminPassword string 

@description('The administrator username')
param adminUsername string

@description('The name of the webserver Vnet.')
param webserverVnetName string = 'vnet-webserv'

@description('The username for the Linux based webserver VM.')
param linuxUser string 

@secure()
@description('The password for the Linux based webserver VM')
param linuxPassword string

@description('The name of the keyvault.')
param keyvault_name string = 'key_vault_jiutvn'

@description('The name of the endpointPolicy.')
param endpointPolicyName string = 'endpointpolicy-${uniqueString(resourceGroup().id)}'

@description('The name of the webserversubnet.')
param webserverSubnetName string = 'webserverSubnet'

@description('The subnet prefix for the webserver Subnet')
param webserverSubnetPrefix string = '10.20.20.0/24'

@description('The name and IP prefix of the webserver Vnet.')
param webserverVnetPrefix string = '10.20.0.0/16'

@description('The name of the management subnet.')
param managementSubnetName string = 'managementSubnet'

@description('The IP prefix of the management vnet.')
param managementVnetPrefix string = '10.10.0.0/16'

@description('The IP prefix of the management subnet.')
param managementSubnetPrefix string = '10.10.10.0/24'

@description('The size of the VMs')
param vm_size string = 'Standard_B1s'

@description('The Linux computername.')
param linuxName string = 'LinuxWebserver'

@description('The name of the VMs')
param vmName string = 'VM'

@description('The name of the Windows based management server.')
param windowsName string = 'adminServer'

@description('The name of the Network Security Group')
param NSG_name string = 'NSG-${uniqueString(resourceGroup().id)}' 

@description('The Uri of the Keyvault.')
param keyvaultUri string = '${keyvault_name}.enviroment()'

param objectId string = '17e2b6ee-f761-4bc6-a5a3-3c7a7b6080c5'

@description('The name of the Backup and recovery Vault')
param vaultName string = 'backupVault-${uniqueString(resourceGroup().id)}'

@description('The name of the backup policy')
param backupPolicyName string = '${vaultName}-policy'

var scheduleRunTimes = [
  '2023-09-05T23:00:00Z'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name:  storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier:'Hot'
    defaultToOAuthAuthentication: false


    encryption:{
      keySource: 'Microsoft.Storage'
      services:{
        blob:{
          enabled:true
      
        }
        file:{
          enabled:true
        }
        queue:{
          enabled:true
        }
        table:{
          enabled:true
        }
      }
      requireInfrastructureEncryption:true
       
      }
      allowBlobPublicAccess:false
      routingPreference:{
        routingChoice:'MicrosoftRouting'
        publishMicrosoftEndpoints:true
      }
      publicNetworkAccess:'Disabled'
      minimumTlsVersion:'TLS1_2'
      supportsHttpsTrafficOnly:true
      isLocalUserEnabled:true
      networkAcls:{
        defaultAction: 'Allow'
        bypass: 'AzureServices'
        virtualNetworkRules:[
          {
            id: '${webservervnet.id}/subnets/webserversubnet'
            action: 'Allow'
            state:'Succeeded'
          }
          {
            id: '${managementvnet.id}/subnets/managementsubnet'
            action: 'Allow'
            state:'Succeeded'
          }
        ]
        ipRules:[]
      }
      dnsEndpointType:'Standard'
      allowSharedKeyAccess:true

      
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


resource endpointPolicy 'Microsoft.Network/serviceEndpointPolicies@2023-04-01' ={
  name: endpointPolicyName
  location:location
  properties:{
    serviceEndpointPolicyDefinitions:[
      {
        id:storageAccount.id
        name:endpointPolicyName
        properties:{
          service:'Microsoft.Storage'
          serviceResources: [
            storageAccount.id
          ]
        }
      }
    ]

  }
}


resource recoveryVault  'Microsoft.RecoveryServices/vaults@2023-04-01' ={
  name: vaultName
  location: location
  sku:{
    name: 'RS0'
    tier: 'Standard'
  }
  properties:{
    publicNetworkAccess:'Enabled'
    restoreSettings:{
      crossSubscriptionRestoreSettings:{
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
    securitySettings:{
      softDeleteSettings:{
        softDeleteState:'Enabled'
        softDeleteRetentionPeriodInDays:7
      }
    }
  }
}


resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-03-01' = {
  parent: recoveryVault
  name: backupPolicyName
  location: location
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 5
    schedulePolicy: {
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: scheduleRunTimes
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      dailySchedule: {
        retentionTimes: scheduleRunTimes
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
      retentionPolicyType: 'LongTermRetentionPolicy'
    }
    protectedItemsCount:0
    timeZone: 'UTC'
  }
}
resource NSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: NSG_name
  location:location
  dependsOn:[
    managementvnet
    webservervnet
  ]
  
  properties:{
    securityRules: [
    {

      name:'AllowSSH'
      properties:{
        access:'Allow'
        direction:'Inbound'
        priority: 300
        protocol:'TCP'
        destinationPortRange:'22'
        destinationAddressPrefix: '*'
        destinationAddressPrefixes:[]
        sourceAddressPrefixes: []
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
      }
    }
    {
      name:'AllowRDP'
      properties:{
        access: 'Allow'
        direction: 'Inbound'
        priority: 320
        protocol: 'TCP'
        destinationPortRange:'3389'
        destinationAddressPrefix: '*'
        destinationAddressPrefixes:[]
        sourceAddressPrefixes: []
        sourceAddressPrefix: '*'
        sourcePortRange: '*' 
      }
    }
    ]
  }
}

//Resources Webserver
resource webservervnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: webserverVnetName
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        webserverVnetPrefix
      ]
    }
    subnets:[
      {
        name: webserverSubnetName
        properties:{
          addressPrefix: webserverSubnetPrefix
          serviceEndpoints:[
            {
              service: 'Microsoft.KeyVault'
              locations:['*']
            }
            {
              service: 'Microsoft.Storage'
              locations:[
                '*'
              ]
            }
            
          ]
        }
      }
    ]
  }
}



resource webserverVM 'Microsoft.Compute/virtualMachines@2023-03-01' ={
  name: 'webserver-${vmName}'
  location: location
  zones:[
    '1'
  ]
  properties:{
    hardwareProfile:{
      vmSize:vm_size
    }
    osProfile:{
      computerName:linuxName
      adminPassword:linuxPassword
      adminUsername: linuxUser
      linuxConfiguration:{
        disablePasswordAuthentication: false 
      }
    }
   securityProfile:{
    encryptionAtHost:true
    securityType:'TrustedLaunch'
    uefiSettings:{
      secureBootEnabled:true
      vTpmEnabled:true
    }
  } 
  
  storageProfile: {
    osDisk:{
      createOption: 'FromImage'
      deleteOption:'Delete'
      osType:'Linux'
      
    }
    imageReference:{
      publisher: 'Canonical'
      offer:'0001-com-ubuntu-server-jammy'
      version: 'latest'
      sku: '22_04-lts-gen2'
    }
  }
  networkProfile:{
    networkInterfaces:[
      {
        id:webservNIC.id
        properties:{
          deleteOption:'Delete'
        }
      }
    ]
    
  }

}

}


resource webservNIC 'Microsoft.Network/networkInterfaces@2023-04-01'= {
  name: 'webservNIC'
  location: location
  properties:{
    nicType:'Standard'
    enableIPForwarding:false
    ipConfigurations:[
      {
        type: 'Microsoft.Network/publicIPAddresses@2023-04-01'
        name:'webserverIP'
        id:webserverIP.id
        properties:{
            privateIPAddressVersion:'IPv4'
            privateIPAllocationMethod:'Dynamic'
            publicIPAddress:{
              id:webserverIP.id
            }
          subnet:{
            name:webserverSubnetName
           properties:{
            addressPrefix:webserverSubnetPrefix
           } 
            id: '${webservervnet.id}/subnets/webserverSubnet'
          }
        }
      }
    ]
  }
}

resource webserverIP 'Microsoft.Network/publicIPAddresses@2023-04-01' ={
  name: 'webserverIPaddress'
  location:location
  sku:{
    name:'Standard'
  }
  zones:[
    '1'
  ]
  properties:{
    publicIPAllocationMethod:'Static'
    deleteOption:'Delete'

  }
}

resource managementvnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: managementVnetName
  location: location
  properties:{
    addressSpace:{
      addressPrefixes: [
        managementVnetPrefix
      ]
    }
    subnets:[
      {
        name: managementSubnetName
        properties:{
          addressPrefix:managementSubnetPrefix
          serviceEndpoints:[
            {
              service: 'Microsoft.KeyVault'
              locations: ['*']
            }
            {
              service: 'Microsoft.Storage'
            }
          ]
         
        }
      }

    ] 
    
    virtualNetworkPeerings:[
      {
        name: 'mngtToWebPeering'
        properties:{
          allowForwardedTraffic:false
          allowGatewayTransit:false
          allowVirtualNetworkAccess:true
          doNotVerifyRemoteGateways:false
          peeringState:'Connected'
          
          remoteAddressSpace:{
            addressPrefixes:[
              '10.20.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace:{
            addressPrefixes:[
             '10.10.0.0/16'
            ]
            
          }
          remoteVirtualNetwork:{
            id: webservervnet.id
          }
          useRemoteGateways:false
          peeringSyncLevel:'FullyInSync'
          
        }

      }
    ]  
  }
}


resource NIC_management 'Microsoft.Network/networkInterfaces@2023-04-01' ={
  name: 'managementNIC'
  location:location
  properties:{
    nicType:'Standard'
    enableIPForwarding:false
    ipConfigurations:[
      {
        type: 'Microsoft.Network/publicIPAddresses@2023-04-01'
        name:'managementNICIp'
        id:managementIP.id
        properties:{
            privateIPAddressVersion:'IPv4'
            privateIPAllocationMethod:'Dynamic'
            publicIPAddress:{
              id:managementIP.id
            }
          subnet:{
            name:managementSubnetName
            properties:{
              addressPrefix:managementVnetPrefix
            }
            id: '${managementvnet.id}/subnets/managementsubnet'
          }
        }
      }
    ]
  }
}


resource managementIP 'Microsoft.Network/publicIPAddresses@2023-04-01' ={
  name: 'managementIPaddress'
  location:location
   sku:{
     name: 'Standard'
   }
  zones:[
    '2'
  ]
  properties:{
    publicIPAllocationMethod:'Static'
    deleteOption:'Delete'

  }
}


resource managementVM 'Microsoft.Compute/virtualMachines@2023-03-01' ={
  name: 'management-${vmName}'
  location: location
  zones:[
  '2'
  ]
  properties:{
    hardwareProfile:{
      vmSize:vm_size
    }
    osProfile:{
      computerName:windowsName
      adminPassword:adminPassword
      adminUsername:adminUsername
    }
  securityProfile:{
    encryptionAtHost:true
  }
  storageProfile: {
    osDisk:{
      createOption: 'FromImage'
      deleteOption:'Delete'
      osType:'Windows'
      
    }
    imageReference:{
      publisher: 'MicrosoftWindowsServer'
      offer:'WindowsServer'
      sku:'2022-datacenter'
      version:'latest'
    }
  }
networkProfile:{
  networkInterfaces:[
    {
      id:NIC_management.id
      properties:{
        deleteOption:'Delete'

      }
    }
  ]
}
  }
}
