resource "azurerm_virtual_network" "virtual_network" {
  name = "vnet-${var.project_name}-${var.environment_tag}"
  location = var.resource_location
  resource_group_name = var.resource_group_name
  address_space = var.address_spaces
  
  tags = {
      environment = var.environment_name
      project = var.project_name
      description = "${var.project_name} virtual network"
  }
}
