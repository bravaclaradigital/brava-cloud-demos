variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "demo"

  validation {
    condition     = contains(["dev", "staging", "prod", "demo"], var.environment)
    error_message = "Environment must be dev, staging, prod, or demo."
  }
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block (e.g. 10.0.0.0/16)."
  }
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

  validation {
    condition     = alltrue([for cidr in var.public_subnets : can(cidrnetmask(cidr))])
    error_message = "All public_subnets entries must be valid CIDR blocks."
  }
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]

  validation {
    condition     = alltrue([for cidr in var.private_subnets : can(cidrnetmask(cidr))])
    error_message = "All private_subnets entries must be valid CIDR blocks."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
