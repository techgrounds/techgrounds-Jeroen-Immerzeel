//module

@description('The location of the resource group.')
param location string = 'germanywestcentral'



//VM algemeen
@description('The size of the VMs')
param vm_size string = 'Standard_B1s'


//VM webserver
@description('The Linux computername.')
param windowsName string = 'adminServer'



//VM management
@description('The name of the VMs')
param vmName string = 'VM'
@description('The name of the management subnet.')
param managementSubnetName string = 'managementSubnet'

@description('The name and IP prefix of the management vnet.')
param managementVnetName string = 'vnet-mngt'

@description('The IP prefix of the management vnet.')
param managementVnetPrefix string = '10.10.0.0/16'

@description('The IP prefix of the management subnet.')
param managementSubnetPrefix string = '10.10.10.0/24'




@description('The administrator password')
@secure()
param adminPassword string 

@description('The administrator username')
@secure()
param adminUsername string



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
      
  }
}



//management NIC en IP

resource NIC_management 'Microsoft.Network/networkInterfaces@2023-04-01' ={
  name: 'managementNIC'
  location:location
  properties:{
    nicType:'Standard'
    enableIPForwarding:true
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


//management VM
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

output webservervnet string = managementVM.name

