data "azurerm_subnet" "private" {
  name                 = var.databricks_workspace_settings.private_subnet_name
  virtual_network_name = var.databricks_workspace_settings.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "public" {
  name                 = var.databricks_workspace_settings.public_subnet_name
  virtual_network_name = var.databricks_workspace_settings.virtual_network_name
  resource_group_name  = var.resource_group_name
}
