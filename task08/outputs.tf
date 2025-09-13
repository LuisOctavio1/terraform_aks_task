output "aks_lb_ip" {
  value = data.kubernetes_service.app_svc.status[0].load_balancer[0].ingress[0].ip
}