variable "project_name" {
  description = "The project name to apply to resources"
  type        = string
}

variable "environment_tag" {
  description = "The type of environment being deployed to in 3 letter form (e.g. dev, tst, prd)"
  type        = string
}

variable "environment_name" {
  description = "The type of environment being deployed to in long form (e.g. development, test, production)"
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

variable "address_spaces" {
  description = "VNET address spaces"
  type        = list(any)
}

variable "subnets" {
  description = "Subnets to be created"
  type        = map(any)
}