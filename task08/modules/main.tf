locals {
  common_tags = { Creator = var.creator }
}

resource "azurerm_resource_group" "rg" {
  name = local.rg_name
  location = var.rg_location
  tags = common_tags
}

module "keyvault" {
  source = "./modules/keyvault"
  kv_name = local.kv_name
  kv_sku = var.kv_sku
  kv_location = var.kv_location
  kv_resource_group = azurerm_resource_group.rg.name
  tags = common_tags
}