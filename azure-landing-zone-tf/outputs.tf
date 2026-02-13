output "resource_group_management_id" {
  description = "Management resource group ID"
  value       = module.rg_management.id
}

output "resource_group_network_id" {
  description = "Network resource group ID"
  value       = module.rg_network.id
}

output "resource_group_workload_id" {
  description = "Workload resource group ID"
  value       = module.rg_workload.id
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = module.network.vnet_id
}

output "vnet_address_space" {
  description = "Virtual Network address space"
  value       = module.network.address_space
}

output "subnet_ids" {
  description = "Subnet IDs by name"
  value       = module.network.subnet_ids
}

output "nsg_id" {
  description = "Network Security Group ID"
  value       = module.network.nsg_id
}
