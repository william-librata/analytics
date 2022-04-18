resource "azurerm_key_vault" "key_vault" {
  name                       = var.key_vault_name
  location                   = var.resource_location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = var.key_vault_settings.soft_delete_retention_days
  purge_protection_enabled   = var.key_vault_settings.purge_protection_enabled
  sku_name                   = var.key_vault_settings.sku_name
  tags                       = merge(var.base_tags, { description = "${var.project_name} key vault" })

}
