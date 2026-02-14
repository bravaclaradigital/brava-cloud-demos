param location string
param hubVnetId string
param hubVnetName string
param spoke1VnetId string
param spoke1VnetName string
param spoke2VnetId string
param spoke2VnetName string

resource peering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${hubVnetName}/peering-to-spoke1'
  properties: {
    remoteVirtualNetwork: {
      id: spoke1VnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${hubVnetName}/peering-to-spoke2'
  properties: {
    remoteVirtualNetwork: {
      id: spoke2VnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}

output peeringStatus string = 'Hub-spoke peering configured'
