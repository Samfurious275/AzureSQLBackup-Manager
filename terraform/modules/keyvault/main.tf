resource "azurerm_key_vault" "kv" {
  name                = "kv-${var.environment}"
  resource_group_name = "sql-rg-${var.environment}"
  location            = "West US"
  tenant_id           = "75df096c-8b72-48e4-9b91-cbf79d87ee3a"
  sku_name            = "standard"
}

resource "azurerm_key_vault_access_policy" "sql_access" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = "75df096c-8b72-48e4-9b91-cbf79d87ee3a"
  object_id    = var.principal_id

  secret_permissions = [
    "Get", "List", "Set", "Delete"
  ]
}
