resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_storage_account" "backup_storage" {
  name                     = "sqlbackupstorage1232"
  resource_group_name      = var.resource_group_name  # ✅ Use input variable
  location                 = var.location             # ✅ Use input variable
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_container" "backup_container" {
  name                  = "sql-backups"
  storage_account_name  = azurerm_storage_account.backup_storage.name
  container_access_type = "private"
}
output "storage_account_name" {
  value = azurerm_storage_account.backup_storage.name
}
