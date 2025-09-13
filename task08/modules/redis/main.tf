resource "azurerm_redis_cache" "this" {
  name = var.redis_name
  resource_group_name = var.redis_rg
  location = var.redis_location
  sku_name = var.redis_sku
  family = var.redis_sku_family
  capacity = var.redis_capacity 
}