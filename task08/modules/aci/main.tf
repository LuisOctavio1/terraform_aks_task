data "azurerm_key_vault_secret" "hostname" {
  name = "redis-hostname"
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "access_key" {
  name = "redis-primary-key"
  key_vault_id = var.kv_id
}

resource "azurerm_container_group" "name" {
  name                = var.aci_name
  location            = var.aci_location
  resource_group_name = var.aci_rg
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label
  os_type             = "Linux"

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_username
    password = var.acr_pwd
  }

  container {
    name   = var.container_name
    image = "${var.acr_login_server}/${var.image_name}:${var.image_tag}"
    ports { port = 8080 }
    cpu    = "0.5"
    memory = "1.5"
    environment_variables = { CREATOR = "ACI", REDIS_PORT = "6380" , REDIS_SSL_MODE = "true"}
    secure_environment_variables = {REDIS_URL = data.azurerm_key_vault_secret.hostname.value, REDIS_PWD = data.azurerm_key_vault_secret.access_key.value }
  }

  tags = var.tags 
}