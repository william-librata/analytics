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

variable "tenant_id" {
  description = "Current tenant id"
  type        = string
}

variable "key_vault_settings" {
  description = "key vault settings"
  type        = map(any)
}

variable "base_tags" {
  description = "Base tags for resources"
  type        = map(any)
}