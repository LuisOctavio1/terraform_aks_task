output "host"                    { value = azurerm_kubernetes_cluster.this.kube_config[0].host }
output "cluster_ca_certificate"  { value = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate }
output "client_certificate"      { value = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate }
output "client_key"              { value = azurerm_kubernetes_cluster.this.kube_config[0].client_key }

# client_id de la UAMI que asignaste al AKS (la misma que distes permisos en KV)
output "kv_uami_client_id" {
  value = azurerm_user_assigned_identity.aks_kv_uami.client_id
}