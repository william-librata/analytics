# data lake
resource "azurerm_storage_account" "data_lake" {
  name                            = "st${var.project_name}datalake${var.environment_tag}"
  resource_group_name             = var.resource_group
  location                        = var.resource_location
  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_account_replication_type
  is_hns_enabled                  = var.is_hns_enabled
  allow_nested_items_to_be_public = true
  min_tls_version                 = "TLS1_2"

  identity {
    type = "SystemAssigned"
  }

  tags                = merge(var.base_tags, { description = "${each.key} private dns" })
}

