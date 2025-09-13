locals {
  common_tags = { Creator = var.creator }
}

resource "azurerm_resource_group" "rg" {
  name = local.rg_name
  location = var.rg_location
  tags = local.common_tags
}

module "keyvault" {
  source = "./modules/keyvault"
  kv_name = local.kv_name
  kv_sku = var.kv_sku
  kv_location = azurerm_resource_group.rg.location
  kv_resource_group = azurerm_resource_group.rg.name
  tags = local.common_tags
}

module "redis" {
  source = "./modules/redis"
  redis_name = local.redis_name
  redis_rg = azurerm_resource_group.rg.name
  redis_location = azurerm_resource_group.rg.location
  redis_sku = var.redis_sku
  redis_sku_family = var.redis_sku_family
  redis_capacity = var.redis_capacity
  redis_kv_id = module.keyvault.id
  tags = local.common_tags
}


module "acr" {
  source = "./modules/acr"
  acr_name = local.acr_name
  acr_resourse_group = azurerm_resource_group.rg.name
  acr_location = azurerm_resource_group.rg.location
  acr_SKU = var.acr_SKU
  image_name = var.image_name
  acr_task_name = var.acr_task_name
  git_pat = var.git_pat
  tags = local.common_tags
  
}

module "aci" {
  source = "./modules/aci"
  aci_name = local.aci_name
  aci_rg = azurerm_resource_group.rg.name
  aci_location = azurerm_resource_group.rg.location
  container_name = var.container_name
  tags = local.common_tags
  kv_id = module.keyvault.id
  acr_login_server = module.acr.acr_login_server
  acr_username = module.acr.acr_username
  acr_pwd = module.acr.acr_pwd
  image_name = var.image_name
  image_tag = var.image_tag
  dns_name_label = var.dns_name_label
  depends_on = [ module.redis, module.acr ]
  
}