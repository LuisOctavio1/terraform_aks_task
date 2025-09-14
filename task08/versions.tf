terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
  }
}

resource "time_sleep" "wait_for_aks" {
  depends_on      = [module.aks]
  create_duration = "120s" # 90–120s suele ser suficiente
}

provider "azurerm" {
  features {}
  subscription_id = "e89aa100-8549-438b-8092-29f3affd8c2a"
}

provider "kubectl" {
  host                   = module.aks.host
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  load_config_file       = false
}
