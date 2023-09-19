param networkInterfaces_mngt_vm758_z2_name string = 'mngt-vm758_z2'
param publicIPAddresses_mngt_vm_ip_externalid string = '/subscriptions/180a468a-5df4-41f7-a716-a1ff81e87bb7/resourceGroups/dev/providers/Microsoft.Network/publicIPAddresses/mngt-vm-ip'
param virtualNetworks_vnet_mngt_externalid string = '/subscriptions/180a468a-5df4-41f7-a716-a1ff81e87bb7/resourceGroups/dev/providers/Microsoft.Network/virtualNetworks/vnet-mngt'

resource networkInterfaces_mngt_vm758_z2_name_resource 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: networkInterfaces_mngt_vm758_z2_name
  location: 'germanywestcentral'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_mngt_vm758_z2_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"b19d3b1d-c6ed-4f30-8fd2-e64409660778"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.10.10.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_mngt_vm_ip_externalid
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: '${virtualNetworks_vnet_mngt_externalid}/subnets/managementSubnet'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}