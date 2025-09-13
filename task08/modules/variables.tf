#common
variable "name_prefix" {
  description = "Prefix for names"
  type        = string
  default     = "cmaz-y010np4n-mod8"
}

variable "rg_location" {
  description = "location of the rg"
  type = string
}

variable "creator" {
    description = "tags of the resources"
    type = string
  
}

#aci
variable "container_name" {
    description = "Name of the container"
    type = string
}

variable "image_name" {
    description = "name of the image"
    type = string
  
}

variable "image_tag" {
    description = "image tag"
    type = string
}

variable "dns_name_label" {
  description = "dnas label for the aci"
  type = string
}

#acr

variable "acr_SKU" {
  description = "Acr tier"
  type = string
}

variable "acr_task_name" {
  description = "name of the acr task"
  type = string
}

variable "git_pat" {
  description = "github token"
  type = string
  sensitive = true  
}

#aks
variable "def_node_name" {
    description = "Default node pool name"
    type = string
  
}

variable "def_node_count" {
    description = "Default node pool instance count"
    type = number
  
}

variable "def_node_size" {
    description = "Default node pool instance node size"
    type = string
}

variable "aks_identity_name" {
    description = "name of the identity"
  type = string
}

variable "kv_sku" {
    description = "sku of the key vault"
    type = string
}

variable "redis_sku" {
    description = "sku of redis"
  type = string
}

variable "redis_sku_family" {
    description = "redis sku family"
    type = string
}

variable "redis_capacity" {
    description = "redis capacity"
    type = number
}



