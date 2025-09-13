output "aks_lb_ip" {
  description = "kubernetes ip"
  value       = data.kubernetes_service.app_svc.status[0].load_balancer[0].ingress[0].ip
}

output "aci_fqdn" {
  description = "aci_fqdn"
  value       = module.aci.aci_fqdn
}