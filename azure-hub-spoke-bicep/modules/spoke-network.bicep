param location string
param environment string
param spokeName string
param vnetAddressSpace string
param subnets array

resource vnetSpoke 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-spoke-${spokeName}-${environment}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressSpace
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
      }
    }]
  }
}

output vnetId string = vnetSpoke.id
output vnetName string = vnetSpoke.name
