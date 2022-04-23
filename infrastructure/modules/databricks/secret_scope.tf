resource "databricks_secret_scope" "databricks" {
  name = var.databricks_key_vault_settings.secret_scope_name

  keyvault_metadata {
    resource_id = data.azurerm_key_vault.key_vault.id
    dns_name    = data.azurerm_key_vault.key_vault.vault_uri
  }
}