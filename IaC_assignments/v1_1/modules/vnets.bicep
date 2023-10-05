param location string = resourceGroup().location

param VMSS_Subnet string
param VMSSnetSubnetPrefix string 
param VMSS_vnet string
param VMSSVnetPrefix string
param VMSS_subnetID string

param managementVnetName string
param managementVnetPrefix string
param managementSubnetPrefix string
param managementSubnetName string

param gatewaySubnetID string
param gatewaySubnetName string
param gatewayAddressPrefix string

param adminIP string
param NSG_name string

param adminVM_size string



/*@description('The IP prefix of the management vnet.')
param managementSubnetPrefix string*/

param managementName string
param windowsName string

@description('The administrator password')
@secure()
param adminPassword string

@secure()
@description('The administrator username')
param adminUsername string

//VMSS Vnet

resource VMSSnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: VMSS_vnet
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        VMSSVnetPrefix
      ]
    }
    subnets:[
      {
        name: VMSS_Subnet
        id: VMSS_subnetID
        properties:{
          addressPrefix: VMSSnetSubnetPrefix
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
      {
        name: gatewaySubnetName
        id:gatewaySubnetID
        properties:{
          addressPrefix:gatewayAddressPrefix
          networkSecurityGroup:{
            id: VMSSVnetNSG.id
          }
        }
      }
    ]
    
  }
}


//management Vnet

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
          networkSecurityGroup:{
            id:managementNSG.id
          }
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

  }
}

resource VnetPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  parent: managementvnet
  name: 'managetementToVMSS'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: VMSSnet.id
    }
  }
}
resource VnetPeering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  parent: VMSSnet
  name: 'VMSStoManagement'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: managementvnet.id
    }
  }
}


//Network Security Group
resource VMSSVnetNSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: '${NSG_name}-webserver'
  location: location
  properties: {
    
    securityRules: [
      {
        name: 'sshFromMngmt'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: managementIP.properties.ipAddress
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'httpForWebserver'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
        }
      }
      {
        name: 'httpsForWebserver'// ADDED FOR APP GATEWAY CHANGE
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
        }
      }
      {
        name: 'gatewayPorts-inbound'
        properties:{
          access: 'Allow'
          direction: 'Inbound'
          priority: 200
          protocol: 'Tcp'
          destinationPortRange: '65200-65535'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes:[]
          sourceAddressPrefixes: []
          sourceAddressPrefix: '*'
          sourcePortRange: '*'

        }
      }
      {
        name: 'gatewayPorts-outbound'
        properties:{
          access: 'Allow'
          direction: 'Outbound'
          priority: 210
          protocol: 'Tcp'
          destinationPortRange: '65200-65535'
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

// NSG for the management vnet (only allow access from trusted locations/IP)
resource managementNSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: '${NSG_name}-management'
  location: location
  properties: {
    
    securityRules: [
      {
        name: 'sshIntoMngmt'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: adminIP
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 101
          direction: 'Inbound'
        }
      }
      {
        name: 'rdpIntoMngmt'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: adminIP
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 102
          direction: 'Inbound'
        }
      }
    ]
  }
}


resource managementVM 'Microsoft.Compute/virtualMachines@2023-07-01' ={
  name: managementName
  location: location
  zones:[
  '2'
  ]
  properties:{
    hardwareProfile:{
      vmSize:adminVM_size
    }
    osProfile:{
      computerName:windowsName
      adminPassword:adminPassword
      adminUsername:adminUsername
      windowsConfiguration:{
        patchSettings:{
          enableHotpatching:true
          patchMode: 'AutomaticByPlatform'
        }
        provisionVMAgent:true
        enableAutomaticUpdates:true
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
      osType:'Windows'
      
    }
    imageReference:{
      publisher: 'MicrosoftWindowsServer'
      offer:'WindowsServer'
      sku:'2022-datacenter-azure-edition-hotpatch'
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
diagnosticsProfile:{
  bootDiagnostics:{
    enabled:true
  }
}
  }
}

resource managementIP 'Microsoft.Network/publicIPAddresses@2023-05-01' ={
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



resource NIC_management 'Microsoft.Network/networkInterfaces@2023-05-01' ={
  name: 'managementNIC'
  location:location
  properties:{
    nicType:'Standard'
    enableIPForwarding:false
    networkSecurityGroup:{
      id: managementNSG.id
    }
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
