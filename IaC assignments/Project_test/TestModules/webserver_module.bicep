
@description('The location of the resource group.')
param location string = 'germanywestcentral'



@description('The name of the webserversubnet.')
param webserverSubnetName string = 'webserverSubnet'

@description('The subnet prefix for the webserver Subnet')
param webserverSubnetPrefix string = '10.20.20.0/24'

@description('The name of the webserver Vnet.')
param webserverVnetName string = 'vnet-webserv'

@description('The name and IP prefix of the webserver Vnet.')
param webserverVnetPrefix string = '10.20.0.0/16'


//VM algemeen
@description('The size of the VMs')
param vm_size string = 'Standard_B1s'


//webserver
@secure()
@description('The webserver administrator password')
param webserverAdminPassword string

@secure()
@description('The webserver administrator username')
param webserverAdminUsername string 




//VM management
@description('The name of the VMs')
param vmName string = 'VM'
@description('The name of the management subnet.')
param managementSubnetName string = 'managementSubnet'

@description('The name and IP prefix of the management vnet.')
param managementVnetName string = 'vnet-mngt'

//VM webserver

@description('The Linux computername.')
param linuxName string = 'LinuxWebserver'

//Key vault
@description('The Uri of the Keyvault.')
param keyvaultUri string = '${keyvault_name} enviroment()'

@description('The name of the keyvault.')
param keyvault_name string

//refferences


resource keyvault 'Microsoft.KeyVault/vaults@2023-02-01' existing ={
  name: keyvault_name
}


//resources
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
      adminPassword: webserverAdminPassword
      adminUsername: webserverAdminUsername
      linuxConfiguration:{
        disablePasswordAuthentication: false 
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
    enableIPForwarding:true
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


output webservervnet string = webservervnet.name
