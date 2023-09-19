
@description('The location of the resource group.')
param location string = 'germanywestcentral'

//network information

@description('The name of the webserversubnet.')
param webserverSubnetName string = 'webserverSubnet'

@description('The subnet prefix for the webserver Subnet')
param webserverSubnetPrefix string = '10.20.20.0/24'

@description('The name of the webserver Vnet.')
param webserverVnetName string = 'vnet-webserv'

@description('The name and IP prefix of the webserver Vnet.')
param webserverVnetPrefix string = '10.20.0.0/16'

@description('The name of the management subnet.')
param managementSubnetName string = 'managementSubnet'

@description('The name and IP prefix of the management vnet.')
param managementVnetName string = 'vnet-mngt'

@description('The IP prefix of the management vnet.')
param managementVnetPrefix string = '10.10.0.0/16'

@description('The IP prefix of the management subnet.')
param managementSubnetPrefix string = '10.10.10.0/24'

//VM general data
@description('The size of the VMs')
param vm_size string = 'Standard_B1s'


//VM webserver
@description('The Linux computername.')
param linuxName string = 'LinuxWebserver'


@description('The username for the Linux based webserver VM.')
param linuxUser string 

@secure()
@description('The password for the Linux based webserver VM')
param linuxPassword string



//VM management
@description('The name of the VMs')
param vmName string = 'VM'

@description('The name of the Windows based management server.')
param windowsName string = 'adminServer'

@description('The administrator password')
@secure()
param adminPassword string 

@description('The administrator username')
param adminUsername string

//NSG
@description('The name of the Network Security Group')
param NSG_name string = 'NSG-${uniqueString(resourceGroup().id)}' 

//Network security group

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

//Resources Management Server

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
