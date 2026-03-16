terraform {
  backend "azurerm" {
    # Storage account and resource group are passed at init time via -backend-config
    # flags or a backend.hcl file (see backend.hcl.example).
    # This keeps tenant-specific values out of version control.
    #
    # Local init:
    #   terraform init -backend-config=backend.hcl
    #
    # CI/CD (GitHub Actions):
    #   ARM credentials are read from AZURE_CREDENTIALS secret automatically.
    container_name = "tfstate"
    key            = "azure-landing-zone.tfstate"
  }
}
