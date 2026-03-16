variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-brava-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}

# DEMO NOTE: The AllowRDP rule below permits RDP from any source (0.0.0.0/0).
# This is intentional for demo accessibility. In production, restrict the
# source_address_prefix to known IP ranges or a Bastion subnet only.
# See: https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview
resource "azurerm_network_security_group" "this" {
  name                = "nsg-brava-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "address_space" {
  value = azurerm_virtual_network.this.address_space
}

output "subnet_ids" {
  value = {
    for k, v in azurerm_subnet.this : k => v.id
  }
}

output "nsg_id" {
  value = azurerm_network_security_group.this.id
}
