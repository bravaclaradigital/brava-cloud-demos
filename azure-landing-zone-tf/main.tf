terraform {
  required_version = ">= 1.5"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  
  subscription_id = var.azure_subscription_id
}

# Management Resource Group
module "rg_management" {
  source = "./modules/resource-group"
  
  name     = "rg-brava-management-${var.environment}"
  location = var.azure_location
  environment = var.environment
  cost_center = var.cost_center
  
  tags = merge(
    local.common_tags,
    {
      Purpose = "Management"
    }
  )
}

# Networking Resource Group
module "rg_network" {
  source = "./modules/resource-group"
  
  name     = "rg-brava-network-${var.environment}"
  location = var.azure_location
  environment = var.environment
  cost_center = var.cost_center
  
  tags = merge(
    local.common_tags,
    {
      Purpose = "Networking"
    }
  )
}

# Workload Resource Group
module "rg_workload" {
  source = "./modules/resource-group"
  
  name     = "rg-brava-workload-${var.environment}"
  location = var.azure_location
  environment = var.environment
  cost_center = var.cost_center
  
  tags = merge(
    local.common_tags,
    {
      Purpose = "Workload"
    }
  )
}

# Network Module
module "network" {
  source = "./modules/network"
  
  resource_group_name  = module.rg_network.name
  location             = var.azure_location
  environment          = var.environment
  vnet_address_space   = var.vnet_address_space
  
  subnets = {
    jumphost = {
      name             = "snet-jumphost"
      address_prefixes = var.jumphost_subnet_prefix
    }
    workload = {
      name             = "snet-workload"
      address_prefixes = var.workload_subnet_prefix
    }
    management = {
      name             = "snet-management"
      address_prefixes = var.management_subnet_prefix
    }
  }
  
  tags = local.common_tags
}

# RBAC Module (demonstrates custom roles)
module "rbac" {
  source = "./modules/rbac"
  
  environment = var.environment
  resource_group_ids = [
    module.rg_management.id,
    module.rg_network.id,
    module.rg_workload.id
  ]
  
  tags = local.common_tags
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = "brava-cloud-demos"
    ManagedBy   = "Terraform"
    CostCenter  = var.cost_center
  }
}
