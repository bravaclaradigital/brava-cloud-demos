variable "environment" {
  type = string
}

variable "resource_group_ids" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

# Placeholder for RBAC demo
# In production, this would create custom roles and assignments

output "demo_message" {
  value = "RBAC module demonstrates custom role creation and assignment patterns"
}
