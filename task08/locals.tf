locals {
  rg_name      = format("%s-rg", var.name_prefix)
  redis_name   = format("%s-redis", var.name_prefix)
  kv_name      = format("%s-kv", var.name_prefix)
  acr_base_raw = replace(var.name_prefix, "-", "")
  acr_name     = substr("${local.acr_base_raw}acr", 0, 50)
  aci_name     = format("%s-ci", var.name_prefix)
  aks_name     = format("%s-aks", var.name_prefix)
}