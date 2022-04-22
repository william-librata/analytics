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

variable "storage_account_settings" {
  description = "Storage account settings"
  type        = map(any)
}

variable "base_tags" {
  description = "Base tags for resources"
  type        = map(any)
}