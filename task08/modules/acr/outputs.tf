output "acr_login_server" {
  description = "login server to acr"
  value       = azurerm_container_registry.this.login_server
}

output "acr_pwd" {
  description = "login server to acr"
  value       = azurerm_container_registry.this.admin_password
  sensitive = true
}

output "acr_username" {
  description = "login server to acr"
  value       = azurerm_container_registry.this.admin_username
  sensitive = true
}

output "acr_id" {
  description = "acr id"
  value       = azurerm_container_registry.this.id
  sensitive = true
}
