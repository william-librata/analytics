resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  address_space       = var.address_spaces
  tags                = merge(var.base_tags, { description = "${var.project_name} virtual network" })
}
