data "azurerm_virtual_network" "virtual_network" {
  name                = var.databricks_workspace_settings.virtual_network_name
  resource_group_name = var.resource_group_name
}