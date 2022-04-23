# databricks workspace
resource "azurerm_databricks_workspace" "databricks" {
  name                          = var.databricks_workspace_settings.name
  resource_group_name           = var.resource_group_name
  managed_resource_group_name   = var.databricks_workspace_settings.managed_resource_group_name
  location                      = var.resource_location
  sku                           = var.databricks_workspace_settings.sku
  public_network_access_enabled = var.databricks_workspace_settings.public_network_access_enabled

  custom_parameters {
    public_ip_name = var.databricks_workspace_settings.public_ip_name

    virtual_network_id = data.azurerm_virtual_network.virtual_network.id

    public_subnet_name                                  = var.databricks_workspace_settings.public_subnet_name
    public_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.databricks_public.id

    private_subnet_name                                  = var.databricks_workspace_settings.private_subnet_name
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.databricks_private.id

    storage_account_name = var.databricks_workspace_settings.storage_account_name
  }

  tags = merge(var.base_tags, { description = "${var.project_name} databricks workspace" })
}

