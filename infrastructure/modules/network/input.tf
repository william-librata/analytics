variable "project_name" {
  description = "Project name"
  type        = string
}

variable "resource_location" {
  description = "The location of the resource"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual network name"
  type        = string
}

variable "address_spaces" {
  description = "VNET address spaces"
  type        = list(any)
}

variable "subnets" {
  description = "Subnets to be created"
  type        = map(any)
}

variable "base_tags" {
  description = "Base tags for resources"
  type        = map(any)
}