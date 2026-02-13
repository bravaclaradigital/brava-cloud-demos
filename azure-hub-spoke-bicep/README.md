# Azure Hub-Spoke Architecture with Bicep

Deploy a **production-ready hub-spoke network topology** with Azure Bicep for multi-workload isolation and centralized security.

## What This Demo Deploys

✅ **Hub Virtual Network** — Central network with gateway, firewall, and Bastion subnets  
✅ **Spoke Virtual Networks** — 2+ isolated spokes for workload segregation  
✅ **VNet Peering** — Connectivity between hub and all spokes  
✅ **Azure Bastion** — Jumphost without public IPs  
✅ **Network Security Groups** — Per-subnet security rules  

## Quick Start

### Prerequisites
- Azure subscription with Contributor access
- Azure CLI with Bicep support
- Git

### Deployment

```powershell
# 1. Create resource group
az group create --name rg-brava-hub-spoke-demo --location eastus

# 2. Deploy with Bicep
az deployment group create `
  --resource-group rg-brava-hub-spoke-demo `
  --template-file main.bicep `
  --parameters parameters.bicepparam

# 3. View outputs
az deployment group show `
  --resource-group rg-brava-hub-spoke-demo `
  --name main
```

### Cleanup

```powershell
az group delete --resource-group rg-brava-hub-spoke-demo --yes
```

## Architecture

```
                    ┌──────────────────────┐
                    │   HUB VNET           │
                    │  (10.0.0.0/23)       │
                    │ ┌────────────────┐   │
                    │ │ Gateway Subnet │   │
                    │ │ Firewall       │   │
                    │ │ Bastion        │   │
                    │ └────────────────┘   │
                    └──────────┬───────────┘
                               │
                ┌──────────────┼──────────────┐
                ▼              ▼              ▼
           ┌────────┐     ┌────────┐    ┌────────┐
           │SPOKE 1 │     │SPOKE 2 │    │SPOKE 3 │
           │ App    │     │Database│    │...     │
           └────────┘     └────────┘    └────────┘
```

## Modules

- **hub-network.bicep** — Hub VNet with gateway and Bastion
- **spoke-network.bicep** — Spoke VNet for workloads
- **connectivity.bicep** — VNet peering rules

## Key Outputs

After deployment, you'll receive:
- Hub VNet ID
- Spoke VNet IDs
- Bastion public IP for access

## Cost Estimate

**Deployment:** ~$10-20/day (Bastion and NAT costs)  
**Cleanup:** $0 (resources destroyed)

## Talking Points

- "Hub-spoke scales from 10 to 1000+ spokes, all managed centrally"
- "Bastion eliminates public IPs — no SSH key exposure"
- "Spokes can be managed by different teams while hub enforces security"
- "This follows the Azure Well-Architected Framework"

