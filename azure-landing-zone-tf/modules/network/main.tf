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

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-brava-\"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.vnet_address_space
  
  tags = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets
  
  name                 = each.value.name
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "this" {
  name                = "nsg-brava-\"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name
  
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
