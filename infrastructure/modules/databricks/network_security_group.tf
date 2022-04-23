# network security group for databricks
resource "azurerm_network_security_group" "databricks_private" {
  name                = var.databricks_workspace_settings.network_security_group_private_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  tags = merge(var.base_tags, { description = "${var.project_name} databricks private nsg" })
}

resource "azurerm_network_security_group" "databricks_public" {
  name                = var.databricks_workspace_settings.network_security_group_public_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  tags = merge(var.base_tags, { description = "${var.project_name} databricks public nsg" })
}

# nsg association
resource "azurerm_subnet_network_security_group_association" "databricks_private" {
  subnet_id                 = data.azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.databricks_private.id
}

resource "azurerm_subnet_network_security_group_association" "databricks_public" {
  subnet_id                 = data.azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.databricks_public.id
}
