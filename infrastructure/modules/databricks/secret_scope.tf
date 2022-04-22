provider "databricks" {
  host = azurerm_databricks_workspace.databricks.workspace_url
}

resource "databricks_secret_scope" "databricks" {
  name = var.databricks_key_vault_settings.secret_scope_name

  keyvault_metadata {
    resource_id = var.key_vault_id
    dns_name    = var.key_vault_uri
  }
}