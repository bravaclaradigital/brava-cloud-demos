# Brava Cloud Infrastructure Demos

Production-ready cloud infrastructure demonstrations showcasing modern DevOps, Infrastructure as Code, and automation practices. Built for rapid deployment, live presentations, and proof-of-concept validation.

## About

This repository contains hands-on Azure and AWS infrastructure demos that highlight practical cloud architecture, Infrastructure as Code, CI/CD automation, and environment teardown workflows for fast demos and proof-of-concept work.

## Demo Projects

| Demo | Cloud | IaC Tool | Deploy Time | Hourly Cost | Destroy Time |
|------|-------|----------|-------------|-------------|--------------|
| [Azure Landing Zone](azure-landing-zone-tf/) | Azure | Terraform | ~3-5 min | **$0.00** | ~2 min |
| [AWS Cloud CI/CD](aws-cloud-cicd-tf/) | AWS | Terraform | ~2-3 min | **~$0.07** | ~3 min |
| [Azure Hub-Spoke](azure-hub-spoke-bicep/) | Azure | Bicep | ~5-7 min | **~$0.20** | ~2 min |

Each demo is fully independent. Deploy one or all three.

---

### 1. Azure Landing Zone with Terraform Modules

Governance, networking, and RBAC patterns for enterprise Azure.

- Three resource groups (Management, Networking, Workload)
- VNet with segmented subnets (jumphost, workload, management)
- Custom RBAC role with scoped assignments
- Zero ongoing cost (networking only)

[View README](azure-landing-zone-tf/README.md)

---

### 2. AWS Cloud CI/CD with Terraform

Complete CI/CD-ready infrastructure on AWS.

- VPC with public/private subnets across 2 AZs
- NAT Gateway for private subnet egress
- EC2 with Apache (browse to public IP after deploy)
- IAM least-privilege roles, GitHub Actions automation

[View README](aws-cloud-cicd-tf/README.md)

---

### 3. Azure Hub-Spoke Architecture with Bicep

Multi-workload network isolation with centralized security.

- Hub VNet with Azure Bastion (no public IPs on workloads)
- Three spoke VNets (App, Database, Monitoring)
- Bidirectional VNet peering
- Log Analytics Workspace for centralized logging

[View README](azure-hub-spoke-bicep/README.md)

---

## Repository Structure

```
brava-cloud-demos/
├── .github/workflows/            # Independent CI/CD pipelines per demo
│   ├── deploy-aws-cloud-cicd.yml
│   ├── deploy-azure-landing-zone.yml
│   ├── deploy-azure-hub-spoke.yml
│   └── drift-detection.yml       # Daily drift check across all demos
├── aws-cloud-cicd-tf/            # Demo: AWS CI/CD
│   ├── modules/                  # vpc, security-group, iam, compute
│   ├── backend.hcl.example       # Copy to backend.hcl for local init
│   └── README.md
├── azure-landing-zone-tf/        # Demo: Azure Landing Zone
│   ├── modules/                  # resource-group, network, rbac
│   ├── backend.hcl.example       # Copy to backend.hcl for local init
│   └── README.md
└── azure-hub-spoke-bicep/        # Demo: Hub-Spoke
    ├── modules/                  # hub-network, spoke-network, connectivity
    └── README.md
```

## GitHub Actions Workflows

All workflows use `workflow_dispatch` with an `action` input (`apply` or `destroy`):

1. Run from the **Actions** tab in GitHub
2. Click **Run workflow**
3. Select `apply` to deploy or `destroy` to tear down

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) to add a new demo or update an existing one.

---

**License:** MIT
