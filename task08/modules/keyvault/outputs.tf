output "id" {
  description = "Key Vault resource ID"
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "Key Vault resource name"
  value       = azurerm_key_vault.this.name
}