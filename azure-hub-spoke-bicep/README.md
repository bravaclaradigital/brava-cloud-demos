# Azure Hub-Spoke Architecture with Bicep

Deploy a **production-ready hub-spoke network topology** with Azure Bicep for multi-workload isolation and centralized security.

## What This Demo Deploys

✅ **Hub Virtual Network** — Central network with gateway, firewall, and Bastion subnets  
✅ **Spoke Virtual Networks** — 2+ isolated spokes for workload segregation  
✅ **VNet Peering** — Connectivity between hub and all spokes  
✅ **Azure Bastion** — Jumphost without public IPs  
✅ **Network Security Groups** — Per-subnet security rules  

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

After deployment:
- Hub VNet ID
- Spoke VNet IDs
- Bastion public IP for access
