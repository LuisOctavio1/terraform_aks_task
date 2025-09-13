variable "aci_name" {
  description = "container instance name"
  type        = string
}

variable "aci_rg" {
  description = "resource group of container instance"
  type        = string

}

variable "aci_location" {
  description = "aci location"
  type        = string

}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "tags" {
  description = "tags of the aci"
  type        = map(string)

}

variable "kv_id" {
  description = "id of the key vault"
  type        = string

}

variable "acr_login_server" {
  description = "server acr"
  type        = string
}

variable "acr_username" {
  description = "username acr"
  type        = string
  sensitive   = true
}

variable "acr_pwd" {
  description = "acr password"
  type        = string
  sensitive   = true
}

variable "image_name" {
  description = "name of the image"
  type        = string

}

variable "image_tag" {
  description = "image tag"
  type        = string
}

variable "dns_name_label" {
  description = "dnas label for the aci"
  type        = string
}