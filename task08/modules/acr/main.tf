resource "azurerm_container_registry" "this" {
  name                = var.acr_name
  resource_group_name = var.acr_resourse_group
  location            = var.acr_location
  sku                 = var.acr_SKU
}

resource "azurerm_container_registry_task" "this" {
  name = var.acr_task_name
  container_registry_id = azurerm_container_registry.this.id
  platform {
    os = "Linux"
  }
  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/LuisOctavio1/terraform_aks_task.git#master:task08/application"
    context_access_token = var.git_pat
    image_names          = [var.image_name + ":latest"]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "this" {
  container_registry_task_id = azurerm_container_registry_task.this.id
}



