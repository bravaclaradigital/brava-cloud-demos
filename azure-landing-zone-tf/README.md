# Azure Landing Zone with Terraform Modules

Deploy an **enterprise-grade Azure landing zone** demonstrating governance, networking, and RBAC at scale.

## What This Demo Deploys

✅ **Three Resource Groups** — Management, Networking, Workload  
✅ **Virtual Network** — 10.0.0.0/16 with segmented subnets  
✅ **Network Segmentation** — Jumphost, workload, and management subnets  
✅ **Network Security Groups** — Baseline rules for secure communication  
✅ **RBAC Roles** — Custom roles for least-privilege access  

## Quick Start

### Prerequisites
- Azure subscription with Contributor access
- Azure CLI or service principal credentials
- Terraform 1.5+

### Deployment

```powershell
# 1. Initialize Terraform
terraform init

# 2. Create terraform.tfvars from example
cp terraform.tfvars.example terraform.tfvars
# Edit to include your subscription ID and preferred settings

# 3. Plan the deployment
terraform plan -out=tfplan

# 4. Apply
terraform apply tfplan

# 5. View outputs
terraform output
```

### Cleanup

```powershell
terraform destroy
```

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

After deployment, terraform will output:
- Resource group IDs
- Virtual Network ID and address space
- Subnet IDs
- Network Security Group ID

## Cost Estimate

**Deployment:** ~$2-5/day  
**Cleanup:** $0 (resources destroyed)

## Talking Points

- "This is the Azure landing zone pattern from the Well-Architected Framework"
- "Modular design scales from dozens to thousands of resources"
- "RBAC enforces least-privilege across teams"
- "Consistent naming and tagging enables cost tracking and compliance"

