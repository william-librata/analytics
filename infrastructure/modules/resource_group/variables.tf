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
