resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.project_name}-${var.environment_tag}"
  location = var.resource_location

  tags = {
    environment = var.environment_name
    project     = var.project_name
    description = "${var.project_name} resource group"
  }
}