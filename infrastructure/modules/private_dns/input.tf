variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "private_dns_names" {
  description = "Private DNS to be created"
  type        = map(any)
}

variable "base_tags" {
  description = "Base tags for resources"
  type        = map(any)
}