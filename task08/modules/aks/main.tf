data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "aks_kv_uami" {
  name                = var.aks_identity_name
  location            = var.aks_location
  resource_group_name = var.aks_rg
  tags                = var.tags
}
resource "azurerm_kubernetes_cluster" "this" {
  name = var.aks_name
  resource_group_name = var.aks_rg
  location = var.aks_location
  dns_prefix = "${var.aks_name}-dns-lo"

   key_vault_secrets_provider {
    secret_rotation_enabled = false
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_kv_uami.id]
  }


  default_node_pool {
    name = var.def_node_name
    node_count = var.def_node_count
    vm_size = var.def_node_size
    os_disk_type = "Ephemeral"
    os_disk_size_gb  = 64
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "this" {
  scope = var.acr_id
  principal_id  = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = var.aks_kv_id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_user_assigned_identity.aks_kv_uami.principal_id
  secret_permissions = ["Get", "List"]
  depends_on = [azurerm_kubernetes_cluster.this]
  
}

