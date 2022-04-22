# network security group for databricks
resource "azurerm_network_security_group" "databricks_private" {
  name                = var.network_security_group_private_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  tags                = merge(var.base_tags, { description = "${var.project_name} databricks private nsg" })
}

resource "azurerm_network_security_group" "databricks_public" {
  name                = var.network_security_group_public_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  tags                = merge(var.base_tags, { description = "${var.project_name} databricks public nsg" })
}

# nsg association
resource "azurerm_subnet_network_security_group_association" "databricks_private" {
  subnet_id                 = var.network_security_group_private_subnet_id
  network_security_group_id = azurerm_network_security_group.databricks_private.id
}

resource "azurerm_subnet_network_security_group_association" "databricks_public" {
  subnet_id                 = var.network_security_group_private_subnet_id
  network_security_group_id = azurerm_network_security_group.databricks_public.id
}


# databricks workspace
resource "azurerm_databricks_workspace" "databricks" {
  name                          = var.workspace_settings.name
  resource_group_name           = var.resource_group_name
  managed_resource_group_name   = var.workspace_settings.managed_resource_group_name
  location                      = var.resource_location
  sku                           = var.workspace_settings.databricks_sku
  public_network_access_enabled = var.workspace_settings.databricks_public_access

  custom_parameters {
    public_ip_name = var.public_ip_name

    virtual_network_id = var.virtual_network_id

    public_subnet_name                                  = azurerm_subnet.databricks_public.name
    public_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.databricks_public.id

    private_subnet_name                                  = azurerm_subnet.databricks_private.name
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.databricks_private.id

    storage_account_name = var.storage_account_name
  }

  tags                = merge(var.base_tags, { description = "${var.project_name} databricks workspace" })
}

