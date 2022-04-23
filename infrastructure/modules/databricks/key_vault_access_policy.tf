resource "azurerm_key_vault_access_policy" "databricks" {
  key_vault_id       = data.azurerm_key_vault.key_vault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  secret_permissions = var.databricks_key_vault_settings.secret_permissions
}
