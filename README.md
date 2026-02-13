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

---

### ☁️ **3. AWS Cloud CI/CD with Terraform**
A complete CI/CD pipeline demonstration with AWS infrastructure:
- VPC with public/private subnets and NAT
- Security groups and IAM roles with least-privilege
- EC2 instances with auto-scaling capabilities
- GitHub Actions integration for Infrastructure as Code
- Automated testing and secure credential management

**Use Case:** Organizations standardizing Infrastructure as Code deployments across cloud platforms with robust CI/CD practices.

---

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

## GitHub Actions Workflows

Each demo has its own independent CI/CD workflow that can be triggered manually:
- **Terraform validation & plan** for infrastructure changes
- **Automated deployment** via GitHub Actions
- **Destroy infrastructure** for cleanup after demos

---

**License:** MIT
