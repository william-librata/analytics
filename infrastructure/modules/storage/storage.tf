# data lake
resource "azurerm_storage_account" "storage_account" {
  name                            = var.storage_account_settings.name
  resource_group_name             = var.resource_group_name
  location                        = var.resource_location
  account_tier                    = var.storage_account_settings.storage_account_tier
  account_replication_type        = var.storage_account_settings.storage_account_replication_type
  is_hns_enabled                  = var.storage_account_settings.is_hns_enabled
  allow_nested_items_to_be_public = var.storage_account_settings.allow_nested_items_to_be_public
  min_tls_version                 = var.storage_account_settings.min_tls_version

  identity {
    type = "SystemAssigned"
  }

  tags                = merge(var.base_tags, { description = "${var.project_name} data lake" })
}
