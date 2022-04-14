variable "project_name" {
  description = "Project name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "resource_location" {
  description = "Resource location"
  type        = string
}

variable "key_vault_name" {
  description = "Key vault name"
  type        = string
}

variable "tenant_id" {
  description = "Current tenant id"
  type        = string
}

variable "key_vault_soft_delete_retention_days" {
  description = "Soft delete retention days"
  type        = number
}

variable "key_vault_purge_protection_enabled" {
  description = "Purge protection"
  type        = bool
}

variable "key_vault_sku_name" {
  description = "SKU name"
  type        = string
}

variable "base_tags" {
  description = "Base tags for resources"
}