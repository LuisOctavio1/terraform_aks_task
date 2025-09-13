variable "acr_name" {
    description = "name of the acr"
    type = string
}

variable "acr_resourse_group" {
  description = "resource group of the acr"
  type = string
}

variable "acr_location" {
  description = "Acr location"
  type = string
}

variable "acr_SKU" {
  description = "Acr tier"
  type = string
}

variable "image_name" {
    description = "Name of the docker image"
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

variable "tags" {
    description = "key vault tags"
    type = map(string)
  
}

