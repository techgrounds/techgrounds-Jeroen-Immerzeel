//minimal build

@description('The locaton of the resource group')
param location string
var vNetName = 'testVnet'
var subnet_name = 'testSubnet'
param vNetPrefix string = '10.10.0.0/16'
param SubnetPrefix string = '10.10.0.0/24'
param NSG_name string 

var NICname = 'NIC' 

param adminVM_size string

@description('The Linux computername.')
param linuxName string 

@secure()
param linuxUser string

@secure()
param linuxPassword string


resource webserverVM 'Microsoft.Compute/virtualMachines@2023-03-01' ={
  name: 'VM'
  location: location
  zones:[
    '1'
  ]

  properties:{
    hardwareProfile:{
      vmSize:adminVM_size
    }
    osProfile:{
      computerName:linuxName
      adminPassword:linuxPassword
      adminUsername: linuxUser
      linuxConfiguration:{
        disablePasswordAuthentication: false
      }
      customData:loadFileAsBase64('apache.sh')
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
        id:NIC.id
        properties:{
          deleteOption:'Delete'
        }
      }
    ]
  
  }

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



resource vNet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vNetName
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        vNetPrefix
      ]
    }
    subnets:[
      {
        name: subnet_name
        properties:{
          addressPrefix: SubnetPrefix
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


resource NIC 'Microsoft.Network/networkInterfaces@2023-04-01'= {
  name: NICname
  location: location
  properties:{
    nicType:'Standard'
    enableIPForwarding:false
    networkSecurityGroup:{
      id:NSG.id
      location:location
      properties:{
        securityRules:[
          {
            name:'AllowSSH'
            properties:{
              access: 'Allow'
              direction: 'Inbound'
              priority: 300
              protocol: 'Tcp'
              destinationAddressPrefixes:[]
              destinationPortRange:'22'
              sourceAddressPrefixes:[]
              sourcePortRange:'*'
            }
          }
          {
            name:'allowHTTPandHTTPS'
            properties:{
              access: 'Allow'
              direction: 'Inbound'
              priority: 350
              protocol: 'Tcp'
              destinationPortRange:'80, 443'
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
            name:subnet_name
           properties:{
            addressPrefix:SubnetPrefix
           } 
            id: '${vNet.id}/subnets/${subnet_name}'
          }
        }
      }
    ]
  }
}


resource NSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: NSG_name
  location:location
  dependsOn:[
    vNet
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
      name:'allowHTTPS'
      properties:{
        access:'Allow'
        direction: 'Inbound'
        priority: 330
        protocol: 'Tcp'
        destinationPortRange:'443'
        destinationAddressPrefix: '*'
        destinationAddressPrefixes:[]
        sourceAddressPrefixes: []
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
      }
    }
    {
      name:'allowHTTP'
      properties:{
        access: 'Allow'
        direction: 'Inbound'
        priority: 350
        protocol: 'Tcp'
        destinationPortRange:'80'
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
