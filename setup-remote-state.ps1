# Setup Azure Storage for Terraform Remote State
# Run this once before using the Azure workflows

Write-Host "Setting up Azure remote state storage..." -ForegroundColor Cyan

$RESOURCE_GROUP_NAME = "rg-brava-tfstate"
$STORAGE_ACCOUNT_NAME = "bravaterraformstate"
$CONTAINER_NAME = "tfstate"
$LOCATION = "eastus"

# Create resource group
Write-Host "Creating resource group..." -ForegroundColor Yellow
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
Write-Host "Creating storage account..." -ForegroundColor Yellow
az storage account create `
  --resource-group $RESOURCE_GROUP_NAME `
  --name $STORAGE_ACCOUNT_NAME `
  --sku Standard_LRS `
  --encryption-services blob `
  --location $LOCATION

# Create blob container
Write-Host "Creating blob container..." -ForegroundColor Yellow
az storage container create `
  --name $CONTAINER_NAME `
  --account-name $STORAGE_ACCOUNT_NAME `
  --auth-mode login

Write-Host "`nAzure remote state storage created successfully!" -ForegroundColor Green
Write-Host "Resource Group: $RESOURCE_GROUP_NAME"
Write-Host "Storage Account: $STORAGE_ACCOUNT_NAME"
Write-Host "Container: $CONTAINER_NAME"
Write-Host "`nNext: Run 'terraform init -migrate-state' in azure-landing-zone-tf/" -ForegroundColor Cyan
