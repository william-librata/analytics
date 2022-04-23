data "azurerm_key_vault" "key_vault" {
  name                = var.databricks_key_vault_settings.name
  resource_group_name = var.resource_group_name
}