output "host" {
  description = "kubernetes host"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].host
}
output "cluster_ca_certificate" {
  description = "certificate"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
}
output "client_certificate" {
  description = "cliente certificate"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
}
output "client_key" {
  description = "client key"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].client_key
}

output "kubelet_client_id" {
  description = "uami"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].client_id
}