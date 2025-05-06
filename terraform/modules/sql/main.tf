
resource "azurerm_resource_group" "rg" {
  name     = "sql-rg-${var.environment}"
  location = "West US"
}
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = "sql-server-${var.environment}-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = var.sql_admin_password
}
resource "azurerm_mssql_database" "sql_db" {
  name        = "sql-db"
  server_id   = azurerm_mssql_server.sql_server.id  # Use server_id instead of server_name
}

output "sql_server_name" {
  value = azurerm_mssql_server.sql_server.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}
