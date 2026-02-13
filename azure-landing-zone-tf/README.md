# Azure Landing Zone with Terraform Modules

Deploy an **enterprise-grade Azure landing zone** demonstrating governance, networking, and RBAC at scale.

## What This Demo Deploys

✅ **Three Resource Groups** — Management, Networking, Workload  
✅ **Virtual Network** — 10.0.0.0/16 with segmented subnets  
✅ **Network Segmentation** — Jumphost, workload, and management subnets  
✅ **Network Security Groups** — Baseline rules for secure communication  
✅ **RBAC Roles** — Custom roles for least-privilege access  

## Architecture

```
Azure Subscription
├── rg-brava-management-demo
│   └── (future: management resources)
├── rg-brava-network-demo
│   ├── vnet-brava-demo (10.0.0.0/16)
│   │   ├── snet-jumphost (10.0.1.0/24)
│   │   ├── snet-workload (10.0.10.0/24)
│   │   └── snet-management (10.0.20.0/24)
│   └── nsg-brava-demo
└── rg-brava-workload-demo
    └── (future: workloads)
```

## Modules

- **resource-group** — Consistent RG creation with naming conventions
- **network** — VNet, subnets, and NSG with baseline rules
- **rbac** — Custom roles demonstrating least-privilege patterns

## Key Outputs

After deployment:
- Resource group IDs
- Virtual Network ID and address space
- Subnet IDs
- Network Security Group ID
