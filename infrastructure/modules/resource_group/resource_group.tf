resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_location

  tags = merge(var.base_tags, { description = "${var.project_name} resource group" })
}