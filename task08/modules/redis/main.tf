resource "azurerm_redis_cache" "this" {
  name                = var.redis_name
  resource_group_name = var.redis_rg
  location            = var.redis_location
  sku_name            = var.redis_sku
  family              = var.redis_sku_family
  capacity            = var.redis_capacity
  minimum_tls_version = "1.2"
  tags                = var.tags
}

resource "azurerm_key_vault_secret" "hostname" {
  name         = "redis-hostname"
  key_vault_id = var.redis_kv_id
  value        = azurerm_redis_cache.this.hostname
  content_type = "text/plain"
}

resource "azurerm_key_vault_secret" "primary_key" {
  name         = "redis-primary-key"
  key_vault_id = var.redis_kv_id
  value        = azurerm_redis_cache.this.primary_access_key
  content_type = "text/plain"
}