variable "project_name" {
  description = "Project name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "resource_location" {
  description = "Resource group location"
  type        = string
}

variable "base_tags" {
  description = "Base tags for resources"
  type        = map(any)
}

variable "databricks_workspace_settings" {
  description = "Databricks workspace settings"
  type        = map(any)
}

variable "databricks_key_vault_settings" {
  description = "Databricks key vault settings"
  type        = any
}