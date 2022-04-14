resource "azurerm_key_vault" "azurerm_key_vault" {
  name                       = var.key_vault_name
  location                   = var.resource_location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  purge_protection_enabled   = var.key_vault_purge_protection_enabled
  sku_name                   = var.key_vault_sku_name
  tags                       = merge(var.base_tags, { description = "${var.project_name} key vault" })

}


