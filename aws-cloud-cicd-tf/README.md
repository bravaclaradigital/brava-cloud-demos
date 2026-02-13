# AWS Cloud CI/CD with Terraform

Deploy a **complete CI/CD-ready infrastructure** on AWS with automated GitHub Actions pipelines.

## What This Demo Deploys

✅ **VPC** — Custom VPC with public and private subnets  
✅ **NAT Gateway** — Secure outbound internet access  
✅ **Security Groups** — Stateful firewall rules  
✅ **IAM Roles** — Least-privilege instance profiles  
✅ **EC2 Instances** — Auto-configured with web server  
✅ **GitHub Actions CI/CD** — Automated plan, apply, and destroy jobs  

## Architecture

```
AWS Account (us-east-1)
│
└── VPC (10.0.0.0/16)
    │
    ├── Public Subnets (10.0.1.0/24, 10.0.2.0/24)
    │   └── Internet Gateway
    │       └── NAT Gateway
    │           └── EC2 Instance (Web Server)
    │
    └── Private Subnets (10.0.10.0/24, 10.0.11.0/24)
        └── (reserved for future workloads)
```

## Modules

- **vpc** — VPC, subnets, gateways, routing
- **security-group** — Firewall rules for EC2
- **iam** — Instance profile and roles
- **compute** — EC2 instance with auto-configuration

## Key Outputs

After deployment:
- VPC ID
- Instance public IP
- Instance private IP
- Security group ID
