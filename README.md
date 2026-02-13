# Brava Cloud Infrastructure Demos

Production-ready cloud infrastructure demonstrations showcasing modern DevOps, Infrastructure as Code, and automation practices.

## Overview

This repository contains **three distinct cloud infrastructure demo projects**, each demonstrating enterprise-grade cloud architecture patterns and automation workflows. These demos are designed to be deployed, explored in real-time, and torn down cleanly—ideal for technical demonstrations and proof-of-concept validation.

## Demo Projects

### 🏗️ **1. Azure Landing Zone with Terraform Modules**
A modular Azure infrastructure deployment showcasing:
- Subscription and resource group governance
- Network topology and segmentation
- Role-based access control (RBAC) and identity management
- Reusable Terraform modules for scalability
- CI/CD pipeline integration

**Use Case:** Enterprise organizations modernizing Azure infrastructure with repeatable, scalable patterns.

**Deploy Estimate:** ~5-10 minutes | **Cost (Demo):** ~$5-15/day

---

### 🌐 **2. Azure Hub-Spoke Architecture with Bicep**
A complete hub-spoke network topology demonstrating:
- Central hub virtual network with shared services
- Spoke virtual networks for workload isolation
- Virtual network peering and routing
- Azure Bastion for secure access
- Application Gateway and load balancing
- Infrastructure as Code with Microsoft Bicep

**Use Case:** Organizations needing multi-workload Azure environments with centralized security and management.

**Deploy Estimate:** ~8-12 minutes | **Cost (Demo):** ~$10-20/day

---

### ☁️ **3. AWS Cloud CI/CD with Terraform**
A complete CI/CD pipeline demonstration with AWS infrastructure:
- VPC with public/private subnets and NAT
- Security groups and IAM roles with least-privilege
- EC2 instances with auto-scaling capabilities
- GitHub Actions integration for Infrastructure as Code
- Automated testing and secure credential management

**Use Case:** Organizations standardizing Infrastructure as Code deployments across cloud platforms with robust CI/CD practices.

**Deploy Estimate:** ~6-10 minutes | **Cost (Demo):** ~$8-18/day

---

## Quick Start

Each demo project is **completely independent**. Deploy any or all of them:

```bash
# Clone the repository
git clone https://github.com/<your-org>/brava-cloud-demos.git
cd brava-cloud-demos

# Deploy individual demo (see project README for detailed instructions)
cd azure-landing-zone-tf
terraform init
terraform plan
terraform apply

# Or deploy via GitHub Actions (see .github/workflows/)
```

## Prerequisites

- **Cloud Accounts:**
  - Azure subscription (for Azure demos)
  - AWS account (for multi-cloud demo)
  
- **Local Tools:**
  - Terraform 1.5+
  - Azure CLI / AWS CLI
  - Git
  - Bicep CLI (for hub-spoke demo)

- **Credentials:**
  - Azure service principal or user authentication
  - AWS credentials configured locally

## Repository Structure

```
brava-cloud-demos/
├── .github/workflows/          # Independent CI/CD pipelines
├── azure-landing-zone-tf/      # Demo 1: Azure Landing Zone
├── azure-hub-spoke-bicep/      # Demo 2: Hub-Spoke with Bicep
└── aws-cloud-cicd-tf/          # Demo 3: AWS Cloud CI/CD
```

## Key Features Across All Demos

✅ **Production-Ready Code** — Enterprise patterns, error handling, modularity  
✅ **Rapid Deploy/Teardown** — Perfect for 30-45 minute demos  
✅ **Cloud Best Practices** — Security, cost optimization, compliance  
✅ **Full CI/CD Integration** — Automated testing and deployment  
✅ **Modular Design** — Reusable components for real-world projects  

## Deployment Guide

### For Demo Delivery:
Each project includes a comprehensive **DEPLOYMENT.md** with step-by-step instructions.

### For Internal Reference:
See **DEPLOYMENT_GUIDE_INTERNAL.md** for technical deep-dives, troubleshooting, and demo talking points.

## GitHub Actions Workflows

Each demo has its own independent CI/CD workflow:
- **Terraform validation & plan** on pull requests
- **Automated apply** on merge to main
- **Destroy infrastructure** via manual trigger (useful for cleanup)

See .github/workflows/ for configuration details.

## Cost Management

All demos use minimal resources during deployment and can be destroyed immediately after each demo:

```bash
terraform destroy  # Clean up and stop incurring costs
```

**Estimated monthly cost if left running:** $25-50 total  
**Cost when destroyed:** $0 

## Support & Documentation

- Project-specific README: See each project folder
- Deployment instructions: See DEPLOYMENT.md in each project
- Internal technical guide: DEPLOYMENT_GUIDE_INTERNAL.md (not included in .gitignore for repository maintainers)

---

**License:** MIT
