variable "redis_name" {
    description = "redis name"
  type = string
}

variable "redis_rg" {
    description = "redis resource group"
  type = string
}

variable "redis_location" {
    description = "redis location"
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