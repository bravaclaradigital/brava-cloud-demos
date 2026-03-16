variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "azure_location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
  default     = "demo"

  validation {
    condition     = contains(["dev", "staging", "prod", "demo"], var.environment)
    error_message = "Environment must be dev, staging, prod, or demo."
  }
}

variable "cost_center" {
  description = "Cost center for billing/chargeback"
  type        = string
  default     = "brava-demos"
}

variable "vnet_address_space" {
  description = "Virtual Network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]

  validation {
    condition     = alltrue([for cidr in var.vnet_address_space : can(cidrnetmask(cidr))])
    error_message = "All vnet_address_space entries must be valid CIDR blocks."
  }
}

variable "jumphost_subnet_prefix" {
  description = "Jumphost subnet CIDR"
  type        = list(string)
  default     = ["10.0.1.0/24"]

  validation {
    condition     = alltrue([for cidr in var.jumphost_subnet_prefix : can(cidrnetmask(cidr))])
    error_message = "All jumphost_subnet_prefix entries must be valid CIDR blocks."
  }
}

variable "workload_subnet_prefix" {
  description = "Workload subnet CIDR"
  type        = list(string)
  default     = ["10.0.10.0/24"]

  validation {
    condition     = alltrue([for cidr in var.workload_subnet_prefix : can(cidrnetmask(cidr))])
    error_message = "All workload_subnet_prefix entries must be valid CIDR blocks."
  }
}

variable "management_subnet_prefix" {
  description = "Management subnet CIDR"
  type        = list(string)
  default     = ["10.0.20.0/24"]

  validation {
    condition     = alltrue([for cidr in var.management_subnet_prefix : can(cidrnetmask(cidr))])
    error_message = "All management_subnet_prefix entries must be valid CIDR blocks."
  }
}
