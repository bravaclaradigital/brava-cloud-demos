terraform {
  required_version = ">= 1.5"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  
  environment    = var.environment
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  
  enable_nat_gateway = true
  enable_vpn_gateway = false
  
  tags = local.common_tags
}

module "security" {
  source = "./modules/security-group"
  
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  
  tags = local.common_tags
}

module "iam" {
  source = "./modules/iam"
  
  environment = var.environment
  
  tags = local.common_tags
}

module "compute" {
  source = "./modules/compute"
  
  environment             = var.environment
  instance_type           = var.instance_type
  subnet_id               = module.vpc.public_subnet_ids[0]
  security_group_id       = module.security.security_group_id
  iam_instance_profile_id = module.iam.instance_profile_id
  
  depends_on = [module.vpc, module.security, module.iam]
  
  tags = local.common_tags
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = "brava-cloud-demos"
    ManagedBy   = "Terraform"
  }
}
