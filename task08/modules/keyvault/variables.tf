variable "kv_name" {
  description = "name of the key vault"
  type        = string
}

variable "kv_sku" {
  description = "sku of the key vault"
  type        = string
}

variable "kv_location" {
  description = "location of the key vault"
  type        = string

}

variable "kv_resource_group" {
  description = "resource group of the key vault"
  type        = string
}

variable "tags" {
  description = "key vault tags"
  type        = map(string)

}