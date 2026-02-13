# AWS Cloud CI/CD with Terraform

Deploy a **complete CI/CD-ready infrastructure** on AWS with automated GitHub Actions pipelines.

## What This Demo Deploys

✅ **VPC** — Custom VPC with public and private subnets  
✅ **NAT Gateway** — Secure outbound internet access  
✅ **Security Groups** — Stateful firewall rules  
✅ **IAM Roles** — Least-privilege instance profiles  
✅ **EC2 Instances** — Auto-configured with web server  
✅ **GitHub Actions CI/CD** — Automated plan, apply, and destroy jobs  

## Quick Start (Local)

### Prerequisites
- AWS account with programmatic access
- Terraform 1.5+
- GitHub repository (for Actions)

### Deployment

```powershell
# 1. Configure AWS credentials
$env:AWS_ACCESS_KEY_ID = "<your-key>"
$env:AWS_SECRET_ACCESS_KEY = "<your-secret>"
$env:AWS_DEFAULT_REGION = "us-east-1"

# 2. Initialize Terraform
terraform init

# 3. Plan
terraform plan -out=tfplan

# 4. Apply
terraform apply tfplan

# 5. View outputs
terraform output

# 6. Access your instance
# Use the instance_public_ip to SSH
```

### Cleanup

```powershell
terraform destroy
```

## CI/CD with GitHub Actions

Push changes to trigger automated workflows:

1. **Pull Request** — \	erraform plan\ validates changes
2. **Merge to Main** — \	erraform apply\ deploys automatically
3. **Manual Destroy** — Destroy job cleans up infrastructure

### Setting Up GitHub Actions

```powershell
# In your GitHub repository, add secrets:
# - AWS_ACCESS_KEY_ID
# - AWS_SECRET_ACCESS_KEY
# - AWS_REGION

# Then push to trigger workflows:
git push origin feature-branch
```

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

## Cost Estimate

**Deployment:** ~$0.05-0.10/hour  
**1 Hour Demo:** ~$0.10  
**Per Month (if left running):** ~$15-30  

## Talking Points

- "Infrastructure is version-controlled — every change is tracked"
- "GitHub Actions automates testing and deployment"
- "This pattern works for any AWS infrastructure — not just this demo"
- "Destroy job lets us clean up instantly when demo is done"

