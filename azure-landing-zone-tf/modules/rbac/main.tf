variable "environment" {
  type        = string
  description = "Environment name"
}

variable "resource_group_ids" {
  type        = list(string)
  description = "List of resource group IDs to scope the role assignments"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

# Data source to get the current Azure client (service principal running Terraform)
data "azurerm_client_config" "current" {}

# Custom role: Brava Infrastructure Reader
# Grants read-only access to networking and compute resources, useful for
# auditors, monitoring tools, or junior engineers who need visibility without
# the ability to make changes.
resource "azurerm_role_definition" "infra_reader" {
  name        = "Brava Infrastructure Reader (${var.environment})"
  scope       = var.resource_group_ids[0]
  description = "Read-only access to networking and compute resources. Used for auditing and monitoring in Brava-managed environments."

  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/networkSecurityGroups/securityRules/read",
      "Microsoft.Network/publicIPAddresses/read",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Compute/virtualMachines/instanceView/read",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/deployments/read",
      "Microsoft.Insights/metrics/read",
      "Microsoft.Insights/logs/read"
    ]
    not_actions = []
  }

  assignable_scopes = var.resource_group_ids
}

# Assign the custom reader role to the current service principal on each
# resource group. In a real environment, replace azurerm_client_config.current
# with the object IDs of your actual users, groups, or managed identities.
resource "azurerm_role_assignment" "infra_reader" {
  for_each = toset(var.resource_group_ids)

  scope              = each.value
  role_definition_id = azurerm_role_definition.infra_reader.role_definition_resource_id
  principal_id       = data.azurerm_client_config.current.object_id

  # skip_service_principal_aad_check avoids a race condition when the SP
  # was just created (AAD replication lag). Safe to use in demo environments.
  skip_service_principal_aad_check = true
}

output "custom_role_id" {
  description = "The ID of the Brava Infrastructure Reader custom role"
  value       = azurerm_role_definition.infra_reader.role_definition_resource_id
}

output "role_assignment_ids" {
  description = "Map of resource group ID to role assignment ID"
  value       = { for k, v in azurerm_role_assignment.infra_reader : k => v.id }
}
