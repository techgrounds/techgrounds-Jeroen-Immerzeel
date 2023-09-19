param location string 

@description('The Linux computername.')
param linuxName string 

@secure()
@description('The username for the Linux based webserver VM.')
param linuxUsername string 

@secure()
@description('The password for the Linux based webserver VM')
param linuxPassword string  

param webserverSubnetName string

param webserverVnetName string



resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' ={
  name: webserverVnetName
  location:location
  properties:{
    addressSpace:{
      addressPrefixes:[
        '10.20.0.0/16'
      ]
    }
    subnets:[
      { 
        name:webserverSubnetName
        properties:{
          addressPrefix: '10.20.20.0/24'
          serviceEndpoints:[
            {
              locations:['*']
              service: 'Microsoft.KeyVault'
            }
            {
              locations:['*']
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
    ]

  }
}

resource webserverIP 'Microsoft.Network/publicIPAddresses@2023-04-01' ={
  name: 'webserverIPaddress'
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

//VM
resource webserverVM 'Microsoft.Compute/virtualMachines@2023-03-01' ={
  name: 'webserverVM'
  location: location
  zones:[
    '1'
  ]

  properties:{
    hardwareProfile:{
      vmSize: 'Standard_B2s'
    }
    osProfile:{
      computerName:linuxName
      adminPassword:linuxPassword
      adminUsername: linuxUsername
      //customData:base64('sudo apt update && sudo apt upgrade -y && sudo apt install apache2 -y && sudo systemctl enable apache2 && sudo systemctl restart apache2')
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

//NIC
resource webservNIC 'Microsoft.Network/networkInterfaces@2023-04-01'= {
  name: 'webservNIC'
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
           name:webserverSubnetName
           id:'${vnet.id}/subnets/webserverSubnet'
           properties:{
            addressPrefix:'10.20.0.0/16'
           } 
          }
        }
      }
    ]
  }
}

resource NSG 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'NSG'
  location:location
  dependsOn:[
    vnet
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


resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing ={
  name: 'keyvault'
}
