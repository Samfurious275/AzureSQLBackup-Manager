
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "12100be1-d71d-4710-8cf2-d85c7a999be1"
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "westus"
}

# Generate random password for SQL
resource "random_password" "sql_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}|:?/~"

}

module "sql" {
  source              = "./modules/sql"
  sql_server_name     = "my-sql-server"
  resource_group_name = module.sql.resource_group_name  # ✅ Pass SQL module's output
  location            = module.sql.resource_group_location  
  admin_username      = "sqladmin"
  admin_password      = var.sql_admin_password  # Now defined in variables.tf
  database_name       = "mydb"
  environment         = var.environment         # Pass environment variable
  sql_admin_password  = var.sql_admin_password
}

# Storage Module
module "storage" {
  source              = "./modules/storage"
  storage_account_name = "mystorageaccount"
   resource_group_name = module.sql.resource_group_name
  location            = module.sql.resource_group_location
  container_name      = "sqlbackups"
  environment = var.environment
}

# Key Vault Module
# module "keyvault" {
 # source              = "./modules/keyvault"
 # environment      = var.environment
 # principal_id     = module.sql.sql_server_principal_id
 # keyvault_name       = "my-keyvault"
 # resource_group_name = azurerm_resource_group.rg.name
 # location            = azurerm_resource_group.rg.location
  # tenant_id           = data.azurerm_client_config.current.tenant_id
 # object_id           = module.sql.sql_server.identity.0.principal_id
# }

# Get current Azure context
data "azurerm_client_config" "current" {}
