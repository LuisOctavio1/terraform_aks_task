variable "aks_name" {
  description = "name of the aks"
  type        = string

}

variable "def_node_name" {
  description = "Default node pool name"
  type        = string

}

variable "def_node_count" {
  description = "Default node pool instance count"
  type        = number

}

variable "def_node_size" {
  description = "Default node pool instance node size"
  type        = string
}

variable "aks_rg" {
  description = "resource group of the aks"
  type        = string

}

variable "aks_location" {
  description = "location of the aks"
  type        = string

}

variable "tags" {
  description = "aks tags"
  type        = map(string)
}

variable "acr_id" {
  description = "acr id"
  type        = string

}

variable "aks_kv_id" {
  description = "aks key vault id"
  type        = string

}

variable "aks_identity_name" {
  description = "name of the identity"
  type        = string
}