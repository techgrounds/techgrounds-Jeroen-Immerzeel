
/*Dit is de werkende versie van de onderdelen Vnets, Keyvault en storage
Nog toe te voegen:
NSGs, VMs, managed Ids
Ook resource group met naam 'production'

Modules:
Main template: Strorage + keyvault + managed IDs
Module network: Vnets, subnets
Module VMs: VMs, NSGs (dit omdat de nodige NSG rules voor de toegang tot VMs worden gebruikt)
*/
//verwijderen van netwerk interfaces

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
//var softdeletion = (environmentType == 'dev') ? false : true
//var softDeleteInDays = (environmentType == 'dev') ? 7 : 90


@description('The name and IP prefix of the managenent vnet.')
param managementVnetName string = 'vnet-mngt'
param managementVnetPrefix string = '10.10.0.0/16'

@description('The name and IP prefix of the webserver Vnet.')
param webserverVnetName string = 'vnet-webserv'
param webserverVnetPrefix string = '10.20.0.0/16'

@description('The prefixes for the subnets.')
param managementSubnetName string = 'managementSubnet'
param webserverSubnetName string = 'webserverSubnet'
param managementSubnetPrefix string = '10.10.10.0/24'
param webserverSubnetPrefix string = '10.20.20.0/24'



@description('The name of the keyvault.')
param keyvault_name string = 'pc11keyvault'


@description('The Uri of the Keyvault.')
param keyvaultUri string = '${keyvault_name} enviroment()'



@description('The name of the endpointPolicy.')
param endpointPolicyName string = 'endpointpolicy-${uniqueString(resourceGroup().id)}'



@description('The id of the mngt NIC')
param mngtNICname string  = 'mngt-NIC'

@description('The id of the webserver NIC')
param webservNICname string  = 'webserv-NIC'


@description('The size of the VMs')
param vm_size string = 'Standard_B1s'


@description('The name of the Network Security Group')
param NSG_name string = 'NSG-${uniqueString(resourceGroup().id)}' 

@description('The name of the public IP addresses')
param publicIPadressName string = 'IpAddress-${uniqueString(resourceGroup().id)}'

@secure()
@description('The administrator password')
param adminPassword string = ''

@description('The administrator username')
@secure()
param adminUsername string = ''

@description('Specifies the SSH public key file. Use "ssh-keygen -t rsa -b 2048" to generate your SSH key pairs.')
param adminPublicKey string

@description('Any custom data that needs to be processed during system boot.')
param customData string = ''

@description('The name of the management VM')
param mngtVmName string = 'mngt-VM'

@description('The name of the webserver VM')
param webservVmName string = 'webserv-VM'

@description('The name of the Backup and recovery Vault')
param backupVaultName string = 'backupVault-${uniqueString(resourceGroup().id)}'

@allowed([
  'LRS'
  'GRS'
  'ZRS'
])
@description('The storage type of the backup vault')
param backupVaultType string = (environmentType == 'prod') ? 'GRS' : 'ZRS'

@description('The name of the backup policy')
param backupPolicyName string = '${backupVaultName}-policy'

//StorageAccount
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


//keyvault
resource pc11keyvault 'Microsoft.KeyVault/vaults@2023-02-01' =  {
  name: keyvault_name
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
  networkAcls:{
    ipRules:[]
    bypass: 'AzureServices'
    defaultAction:'Deny'
    virtualNetworkRules:[
     {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', webserverVnetName, webserverSubnetName)

      ignoreMissingVnetServiceEndpoint: false
     }
     {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', managementVnetName, managementSubnetName)
      ignoreMissingVnetServiceEndpoint: false
     }
    ]
  }

    vaultUri: keyvaultUri
    tenantId: subscription().tenantId
    accessPolicies:[]
    enabledForDeployment:true
    enabledForDiskEncryption:true
    enabledForTemplateDeployment:true
    //enablePurgeProtection:softdeletion
    enableRbacAuthorization:false
    //softDeleteRetentionInDays: softDeleteInDays
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'enabled'
  }
}



// Dit deel moet in een module
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


// later moduliseren

resource mngtNIC 'Microsoft.Network/networkInterfaces@2023-04-01'= {
  name: mngtNICname
  location: location
  properties:{
    nicType:'Standard'
    enableIPForwarding:true
    ipConfigurations:[
      {
        name:publicIPadressName
        properties:{
          publicIPAddress: {
            properties:{
              deleteOption:'Delete'
              ipAddress:publicIPadressName
              publicIPAddressVersion: 'IPv4'
              publicIPAllocationMethod: 'Dynamic'
            }  
            sku:{
              name:'Standard'
            }

          }
          subnet:{
           id: '${managementvnet.id}/subnets/managementsubnet' 
           properties:{
            addressPrefix:managementSubnetPrefix
           }
          }

        }
      }
    ]
    networkSecurityGroup:{
      id:NSG_name
    }
  }
}
/*resource publicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' ={
  name: publicIPadressName
  location:location
  properties:{
    deleteOption:'Detach'
    publicIPAllocationMethod:'Static'

  }
  sku:{
    name:'Standard'
  }
  zones:[
    '2'
  ]
  
}*/

/*
resource publicIP_2 'Microsoft.Network/publicIPAddresses@2023-04-01' ={
  name: '${publicIPadressName}_2'
  location:location
  properties:{
    deleteOption:'Detach'
    publicIPAllocationMethod:'Static'

  }
  sku:{
    name:'Standard'
  }
  zones:[
    '2'
  ]
  
}

*/



resource managementVM 'Microsoft.Compute/virtualMachines@2023-03-01' ={
  name: mngtVmName
  location: location
  zones:[
  '2'
  ]
  properties:{

    hardwareProfile:{
      vmSize:vm_size
    }
    osProfile:{
      adminPassword: adminPassword
      adminUsername: adminUsername
      customData: customData
      linuxConfiguration:{
        disablePasswordAuthentication: true 
        /*
        ssh:{
          publicKeys:[
            
          ]
        }*/
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
      id:mngtNIC.id

    }
  ]
  networkApiVersion:'2020-11-01'
  networkInterfaceConfigurations:[
    {
      name: 'Microsoft.Network/networkInterfaces@2023-04-01'
      properties:{
        ipConfigurations: [
          {
            name: publicIPadressName
            properties:{
              primary: true
              privateIPAddressVersion:'IPv4'
              publicIPAddressConfiguration:{
                name: publicIPadressName
                sku:{
                  name:'Standard'
                }
                properties:{
                  deleteOption:'Detach'
                }
              }
              subnet:{
                id:managementSubnetName
              }
            }
          }
        ]
        networkSecurityGroup:{
          id:NSG_name
        }
      }
    }
  ]
}
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
        protocol:'Tcp'
        destinationPortRange:'22'
        destinationAddressPrefix: '*'
        sourcePortRange: '*'
        sourceAddressPrefix: '*'
        
      //hier?
      }
    }
    {
      name:'AllowRDP'
      properties:{
        access: 'Allow'
        direction: 'Inbound'
        priority: 320
        protocol: 'Tcp'
        destinationPortRange:'3389'
        destinationAddressPrefix: '*'
        sourcePortRange: '*'
        sourceAddressPrefix: '*'
        
      }
    }
    ]

  }
}

resource webservNIC 'Microsoft.Network/networkInterfaces@2023-04-01'= {
  name: webservNICname
  location: location
  properties:{
    nicType:'Standard'
    enableIPForwarding:true
    ipConfigurations:[
      {
        name:publicIPadressName
        properties:{
          publicIPAddress: {
            properties:{
              deleteOption:'Delete'
              publicIPAddressVersion: 'IPv4'
              publicIPAllocationMethod: 'Static'

            } 
          }
          subnet:{
           id: '${webservervnet.id}/subnets/webserversubnet'
           properties:{
            addressPrefix:webserverSubnetPrefix
           } 
          }
        }
      }
    ]
  }
}


resource webservVM 'Microsoft.Compute/virtualMachines@2023-03-01' ={
  name: webservVmName 
  location: location
  zones:[
    '1'
  ]
  properties:{
    hardwareProfile:{
      vmSize:vm_size
    }
    osProfile:{
      adminPassword: adminPassword
      adminUsername: adminUsername
      customData: customData
      linuxConfiguration:{
        disablePasswordAuthentication: true 
        ssh:{
          publicKeys:[
            {
              keyData:adminPublicKey
              path: '/home/${adminUsername}/.ssh/authorized_keys'
            }
          ]
        }
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
  
      }
    ]
    networkApiVersion:'2020-11-01'
    networkInterfaceConfigurations:[
      {
        name: 'Microsoft.Network/networkInterfaces@2023-04-01'
        properties:{
          ipConfigurations: [
            {
              name: publicIPadressName
              properties:{
                primary: true
                privateIPAddressVersion:'IPv4'
                publicIPAddressConfiguration:{
                  name: publicIPadressName
                  sku:{
                    name:'Standard'
                  }
                  properties:{
                    deleteOption:'Detach'
                  }
                }
                subnet:{
                  id:webserverSubnetName
                }
              }
            }
          ]
          networkSecurityGroup:{
            id:NSG_name
          }
        }
      }
    ]
  }
}

}



resource backupVault 'Microsoft.RecoveryServices/vaults@2023-04-01'={
  name: backupVaultName
  location:location
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
  name: backupPolicyName
  location:location
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
