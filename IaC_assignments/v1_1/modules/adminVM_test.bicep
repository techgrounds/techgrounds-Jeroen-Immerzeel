//The management VM resources
//Parameters
@description('The location of the resource group.')
param location string = resourceGroup().location

@description('The size of the VM used for the administration server.')
param adminVM_size string

@description('The name of the management subnet.')
param managementSubnetName string

@description('The name of the management vnet.')
param managementVnetName string

/*@description('The IP prefix of the management vnet.')
param managementSubnetPrefix string*/

@description('The name of the management VM')
param managementName string

@description('The name of the Windows based management server.')
param windowsName string

@description('The administrator password')
@secure()
param adminPassword string

@secure()
@description('The administrator username')
param adminUsername string


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
    ipConfigurations:[
      {
        type: 'Microsoft.Network/publicIPAddresses@2023-04-01'
        name:'managementNICIp'
        id:managementIP.id
        properties:{
            privateIPAllocationMethod:'Dynamic'
            publicIPAddress:{
              id:managementIP.id
            }
          subnet:{
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', managementVnetName, managementSubnetName)
          }
        }
      }
    ]
  }
}

//oud
/*resource NIC_management 'Microsoft.Network/networkInterfaces@2023-04-01' ={
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
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', managementVnetName, managementSubnetName)
          }
        }
      }
    ]
  }
}*/


