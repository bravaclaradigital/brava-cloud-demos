terraform {
  backend "azurerm" {
    resource_group_name  = "rg-brava-tfstate"
    storage_account_name = "bravaterraformstate"
    container_name       = "tfstate"
    key                  = "azure-landing-zone.tfstate"
  }
}
