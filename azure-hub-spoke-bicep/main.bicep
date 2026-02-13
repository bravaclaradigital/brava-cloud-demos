metadata name = 'Azure Hub-Spoke Architecture'
metadata description = 'Production-ready hub-spoke network topology with Bicep'

param location string = 'eastus'
param environment string = 'demo'

// Hub Network
module hub 'modules/hub-network.bicep' = {
  name: 'hub-deployment'
  params: {
    location: location
    environment: environment
    vnetAddressSpace: '10.0.0.0/23'
    subnets: [
      {
        name: 'snet-gateway'
        addressPrefix: '10.0.0.0/25'
      }
      {
        name: 'snet-firewall'
        addressPrefix: '10.0.0.128/25'
      }
      {
        name: 'snet-bastion'
        addressPrefix: '10.0.1.0/24'
      }
    ]
  }
}

// Spoke 1 - App Workload
module spoke1 'modules/spoke-network.bicep' = {
  name: 'spoke1-deployment'
  params: {
    location: location
    environment: environment
    spokeName: 'app'
    vnetAddressSpace: '10.1.0.0/24'
    subnets: [
      {
        name: 'snet-app'
        addressPrefix: '10.1.0.0/25'
      }
      {
        name: 'snet-data'
        addressPrefix: '10.1.0.128/25'
      }
    ]
  }
}

// Spoke 2 - Database Workload
module spoke2 'modules/spoke-network.bicep' = {
  name: 'spoke2-deployment'
  params: {
    location: location
    environment: environment
    spokeName: 'database'
    vnetAddressSpace: '10.2.0.0/24'
    subnets: [
      {
        name: 'snet-db'
        addressPrefix: '10.2.0.0/24'
      }
    ]
  }
}

// Connectivity (Peering)
module connectivity 'modules/connectivity.bicep' = {
  name: 'connectivity-deployment'
  params: {
    location: location
    hubVnetId: hub.outputs.vnetId
    hubVnetName: hub.outputs.vnetName
    spoke1VnetId: spoke1.outputs.vnetId
    spoke1VnetName: spoke1.outputs.vnetName
    spoke2VnetId: spoke2.outputs.vnetId
    spoke2VnetName: spoke2.outputs.vnetName
  }
}

output hubVnetId string = hub.outputs.vnetId
output spoke1VnetId string = spoke1.outputs.vnetId
output spoke2VnetId string = spoke2.outputs.vnetId
output bastionPublicIp string = hub.outputs.bastionPublicIp
