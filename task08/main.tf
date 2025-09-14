locals {
  common_tags = { Creator = var.creator }
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.rg_location
  tags     = local.common_tags
}

module "keyvault" {
  source            = "./modules/keyvault"
  kv_name           = local.keyvault_name
  kv_sku            = var.kv_sku
  kv_location       = azurerm_resource_group.rg.location
  kv_resource_group = azurerm_resource_group.rg.name
  tags              = local.common_tags
}

module "redis" {
  source           = "./modules/redis"
  redis_name       = local.redis_name
  redis_rg         = azurerm_resource_group.rg.name
  redis_location   = azurerm_resource_group.rg.location
  redis_sku        = var.redis_sku
  redis_sku_family = var.redis_sku_family
  redis_capacity   = var.redis_capacity
  redis_kv_id      = module.keyvault.id
  tags             = local.common_tags
}


module "acr" {
  source             = "./modules/acr"
  acr_name           = local.acr_name
  acr_resourse_group = azurerm_resource_group.rg.name
  acr_location       = azurerm_resource_group.rg.location
  acr_SKU            = var.acr_SKU
  image_name         = var.image_name
  acr_task_name      = var.acr_task_name
  git_pat            = var.git_pat
  tags               = local.common_tags

}

module "aci" {
  source           = "./modules/aci"
  aci_name         = local.aci_name
  aci_rg           = azurerm_resource_group.rg.name
  aci_location     = azurerm_resource_group.rg.location
  container_name   = var.container_name
  tags             = local.common_tags
  kv_id            = module.keyvault.id
  acr_login_server = module.acr.acr_login_server
  acr_username     = module.acr.acr_username
  acr_pwd          = module.acr.acr_pwd
  image_name       = var.image_name
  image_tag        = var.image_tag
  dns_name_label   = var.dns_name_label
  depends_on       = [module.redis, module.acr]

}

module "aks" {
  source            = "./modules/aks"
  aks_name          = local.aks_name
  def_node_name     = var.def_node_name
  def_node_count    = var.def_node_count
  def_node_size     = var.def_node_size
  aks_rg            = azurerm_resource_group.rg.name
  aks_location      = azurerm_resource_group.rg.location
  tags              = local.common_tags
  acr_id            = module.acr.acr_id
  aks_kv_id         = module.keyvault.id
  aks_identity_name = var.aks_identity_name
  depends_on        = [module.redis, module.acr]
}

data "azurerm_client_config" "current" {}

resource "kubectl_manifest" "spc" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    kv_name                    = module.keyvault.name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
    aks_kv_access_identity_id  = module.aks.kubelet_client_id
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-primary-key"
  })

  depends_on = [
    time_sleep.wait_for_aks,
    module.aks,
    module.keyvault,
    module.redis
  ]
}

resource "kubectl_manifest" "deploy" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = var.image_name
    image_tag        = var.image_tag
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [
    time_sleep.wait_for_aks,
    kubectl_manifest.spc,
    module.acr
  ]
}

resource "kubectl_manifest" "svc" {
  yaml_body  = file("${path.module}/k8s-manifests/service.yaml")
  depends_on = [kubectl_manifest.deploy, time_sleep.wait_for_aks]
}

data "kubernetes_service" "app_svc" {
  metadata { name = "redis-flask-app-service" }
  depends_on = [kubectl_manifest.svc]
}

