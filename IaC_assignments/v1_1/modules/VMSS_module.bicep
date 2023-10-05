//This is the module used to define the Virtual Networks and Virtual Machines including their constituent parts (NICs and IP addresses).

//These parameters need to be changed


@description('The ssh key used for the webserver; for production change the "web_test_key" to the key created during pre-deployment')
param ssh_key string = loadTextContent('keys_files/ssh_key.pub')


@description('The certificate for the ssl connection; for production change the "example.cert" with the certificate.pfx created during pre-deployement')
param ssl_cert string = loadFileAsBase64('keys_files/cer-Certificate.cer')
//Parameters
//General
@description('The location of the resource group.')
param location string = resourceGroup().location


@description('The name of the webserversubnet.')
param VMSS_Subnet string

@description('The name of the webserver Vnet.')
param VMSS_vnet string


@description('The name of the Application Gateway')
param gateway_name string

var backendPool = 'VMSSpool'

param gatewaySubnetName string = 'gateway_Subnet'


param gatewaySubnetID string = resourceId('Microsoft.Network/virtualNetworks/subnets/', VMSS_vnet ,gatewaySubnetName)


@description('The name of the VMSS VMs')
param VMSS_name string

@description('The Linux computername.')
param linuxName string 

@secure()
@description('The username for the webservers.')
param linuxUsername string 

@secure()
@description('The password for the webservers')
param linuxPassword string 



@description('The size of the webserver VM.')
param VM_size string
//Resources 
// Gateway 

resource applicationGateway 'Microsoft.Network/applicationGateways@2023-05-01' ={
  name: gateway_name
  location: location
  dependsOn:[
    VMSSnet
  ]
  properties:{
    sku:{
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 10
    }
    sslCertificates:[
      {
        name:'mycert'
        properties:{
          data:loadFileAsBase64('keys_files/pfx-certificate.pfx')
          password: 'MI050952'
        }
      }
    ]
    trustedClientCertificates:[
      {
        name: 'test-cert'
        properties:{
          data: ssl_cert 
        }
      }
    ]

    backendAddressPools:[
      {
        name:backendPool
      
      }
    ]
    backendHttpSettingsCollection:[
      {
        name:'backendSettings_collection'
        properties:{
          port:80
          protocol: 'Http'
          requestTimeout: 20
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]
    enableHttp2: true
    frontendIPConfigurations:[
      {
        name:'frontendGatewayIP'
        properties:{
          publicIPAddress:{
            id:gateway_IP.id
          }

        }
        
      }
      {
        name:'FrontendPrivateIP'
        properties:{
          privateIPAllocationMethod: 'Static'
          privateIPAddress: '10.20.30.30'
          subnet:{
            id: resourceId('Microsoft.Network/virtualNetworks/subnets/', VMSS_vnet, gatewaySubnetName)
          }
        }
      }
    ]
    frontendPorts:[
      {
        name: 'HTTPS_port'
        properties:{
          port: 443
        }
      }
       {
        name:'HTTP_redirectPort'
        properties:{
          port: 80
        }
       }
    ]
    
    gatewayIPConfigurations:[
      {
        name:'GatewayIP'
        properties:{
          subnet:{
            id: gatewaySubnetID
          }
        }
      }
      
   
    ]
    httpListeners:[
      {
        name:'redirect_HTTPtoHTTPS_listener'
        properties:{
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations' ,gateway_name, 'frontendGatewayIP')
          }
          
          frontendPort:{
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', gateway_name, 'HTTP_redirectPort')
          }
          protocol:'Http'
          requireServerNameIndication:false
        }

      }
      {
        name: 'HTTPS_listener'
        properties: {
          frontendIPConfiguration:{
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations' ,gateway_name, 'frontendGatewayIP')
          }
          frontendPort:{
            id:resourceId('Microsoft.Network/applicationGateways/frontendPorts/', gateway_name, 'HTTPS_port')
          }
          protocol:'Https'
          requireServerNameIndication:false
          sslCertificate:{
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', gateway_name, 'mycert')
          }
        }
      }
    ]
    listeners:[]
    requestRoutingRules:[
            {
        name: 'HTTPS_RoutingRule'
        properties:{
          ruleType:'Basic'
          httpListener:{
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', gateway_name, 'HTTPS_listener')
          }
          backendAddressPool:{
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', gateway_name, 'VMSSPool')
          }
          backendHttpSettings:{
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', gateway_name,'backendSettings_collection')
          }
          priority: 320
        }
      }
      {
        name: 'HTTP_routingRule'
        properties: {
          ruleType: 'Basic'
          priority: 110
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', gateway_name, 'redirect_HTTPtoHTTPS_listener')
          }
          redirectConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/redirectConfigurations', gateway_name, 'HTTP_to_HTTPS_redirection')
          }
        }
      }
    ]
    probes:[
      {
        name:'gatewayHealthProbe'
        properties:{
          host: '127.0.0.1'
          interval:15
          path: '/'
          port:443
          protocol: 'Https'
          timeout: 10
          unhealthyThreshold: 10
          match:{
            statusCodes:['200']
          } 

        }
      }
    ]
    redirectConfigurations:[
      {
        name: 'HTTP_to_HTTPS_redirection'
        properties:{
          targetListener:{
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', gateway_name, 'HTTPS_listener' )//different from HTTP_routinmrule
          }

          redirectType:'Permanent'
          includePath:true
          includeQueryString:true
        }
      }
    ]
  }


}

resource gateway_IP 'Microsoft.Network/publicIPAddresses@2023-04-01' ={
  name: 'gateway_IP'
  location:location
  sku:{
    name:'Standard'
    tier: 'Regional'
  }
  properties:{
    publicIPAllocationMethod:'Static'
    deleteOption:'Detach'
  }
}



resource VMSS 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: VMSS_name
  location: location
  dependsOn:[
    applicationGateway
  ]
  sku: {
    capacity:3
    name: VM_size
    tier:  'Standard'
  }
  properties: {
    automaticRepairsPolicy:{
      enabled:true
      gracePeriod:'PT10M'
    }
    overprovision: true
    singlePlacementGroup: false
    upgradePolicy: {
      mode: 'Automatic'
    }
    virtualMachineProfile: {
      extensionProfile:{
        extensions:[
          {
            name:'healthExtention'
            properties:{
              autoUpgradeMinorVersion:true
              publisher:'Microsoft.ManagedServices'
              type:'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                protocol: 'http'
                port: 80
              }

            }
          }
        ]
      }
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          osType:'Linux'
        }
        imageReference:{
          offer:'0001-com-ubuntu-server-jammy'
          publisher: 'Canonical'
          sku:'22_04-lts-gen2'
          version:'latest'
        }
      }
      securityProfile:{
        encryptionAtHost: true
      }
      osProfile: {
        linuxConfiguration:{
          disablePasswordAuthentication:true
          ssh:{
            publicKeys:[
              {
                path: '/home/${linuxUsername}/.ssh/authorized_keys'
                keyData: ssh_key 
              }
            ]
          }
        }
        customData: loadFileAsBase64('keys_files/webserver.sh')
        computerNamePrefix: linuxName
        adminUsername: linuxUsername
        adminPassword: linuxPassword
      }
    
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: 'VMSS_NIC'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'IPconfig'
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets/', VMSS_vnet, VMSS_Subnet)
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', gateway_name, backendPool)
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}


resource autoscale 'Microsoft.Insights/autoscalesettings@2022-10-01' ={
  name: 'autoscaler'
  location: location
  properties: {
    targetResourceUri:VMSS.id
    enabled: true
    profiles: [
      {
        name: 'scaler'
        capacity: {
          default: '1'
          maximum: '3'
          minimum: '1'
        }
        rules: [
        {
          metricTrigger: {
            metricName:'Percentage CPU'
            metricResourceUri: VMSS.id
            timeGrain: 'PT1M'
            statistic: 'Average'
            timeWindow: 'PT5M'
            timeAggregation: 'Average'
            operator: 'GreaterThan'
            threshold: 50
          }
          scaleAction: {
            direction: 'Increase'
            type: 'ChangeCount'
            value: '1'
            cooldown: 'PT5M'
          }
        }
        {
          metricTrigger: {
            metricName: 'Percentage CPU'
            metricResourceUri: VMSS.id
            operator: 'LessThan'
            statistic: 'Average'
            threshold: 30
            timeAggregation: 'Average'
            timeGrain: 'PT1M'
            timeWindow: 'PT3M'
          }
          scaleAction: {
            value: '1'
            cooldown: 'PT3M'
            direction: 'Decrease'
            type: 'ChangeCount'
          }
        }
        ]
      }
    ]
  }
}

resource VMSSnet 'Microsoft.Network/virtualNetworks@2023-04-01' existing ={
  name: VMSS_vnet
}
