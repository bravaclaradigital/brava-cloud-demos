param hubVnetId string
param hubVnetName string
param spoke1VnetId string
param spoke1VnetName string
param spoke2VnetId string
param spoke2VnetName string
param spoke3VnetId string
param spoke3VnetName string

// Hub to Spoke1 peering
resource hubToSpoke1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${hubVnetName}/peering-to-spoke1'
  properties: {
    remoteVirtualNetwork: {
      id: spoke1VnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

// Hub to Spoke2 peering
resource hubToSpoke2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${hubVnetName}/peering-to-spoke2'
  properties: {
    remoteVirtualNetwork: {
      id: spoke2VnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

// Spoke1 to Hub peering
resource spoke1ToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${spoke1VnetName}/peering-to-hub'
  properties: {
    remoteVirtualNetwork: {
      id: hubVnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

// Spoke2 to Hub peering
resource spoke2ToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${spoke2VnetName}/peering-to-hub'
  properties: {
    remoteVirtualNetwork: {
      id: hubVnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

// Hub to Spoke3 peering
resource hubToSpoke3 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${hubVnetName}/peering-to-spoke3'
  properties: {
    remoteVirtualNetwork: {
      id: spoke3VnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

// Spoke3 to Hub peering
resource spoke3ToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-11-01' = {
  name: '${spoke3VnetName}/peering-to-hub'
  properties: {
    remoteVirtualNetwork: {
      id: hubVnetId
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

output peeringStatus string = 'Hub-spoke peering configured'
