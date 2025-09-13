data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = var.kv_name
  resource_group_name = var.kv_resource_group
  location            = var.kv_location
  sku_name            = var.kv_sku
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id       = azurerm_key_vault.this.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  secret_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}