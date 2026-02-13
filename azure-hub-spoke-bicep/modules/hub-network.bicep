param location string
param environment string
param vnetAddressSpace string
param subnets array

resource vnetHub 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-hub-\'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressSpace
      ]
    }
  }
}

resource subnetsRes 'Microsoft.Network/virtualNetworks/subnets@2023-11-01' = [for subnet in subnets: {
  parent: vnetHub
  name: subnet.name
  properties: {
    addressPrefix: subnet.addressPrefix
  }
}]

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: 'nsg-hub-\'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2023-11-01' = {
  name: 'bastion-hub-\'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: '\/subnets/snet-bastion'
          }
          publicIPAddress: {
            id: bastionPublicIp.id
          }
        }
      }
    ]
  }
}

resource bastionPublicIp 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: 'pip-bastion-\'
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

output vnetId string = vnetHub.id
output vnetName string = vnetHub.name
output bastionPublicIp string = bastionPublicIp.properties.ipAddress
