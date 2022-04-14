# transient storage account
resource "azurerm_storage_account" "data_lake" {
  name                            = "st${var.department_tag}${var.project_name}datalake${var.environment_tag}"
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = var.resource_location
  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_account_replication_type
  is_hns_enabled                  = var.is_hns_enabled
  allow_nested_items_to_be_public = true
  min_tls_version                 = "TLS1_2"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment_name
    Department  = var.department_name
    CostCentre  = var.cost_centre
    Project     = var.project_name
    Description = "Multipurpose storage account"
    Owner       = var.owner
  }
}

# add storage account private dns
resource "azurerm_private_dns_zone" "data_lake" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.resource_group.name
}

# add link to virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "data_lake" {
  name                  = "pdzvnl-${var.project_name}-data-lake-${var.environment_tag}"
  resource_group_name   = azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.data_lake.name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
}

# add private endpoint
resource "azurerm_private_endpoint" "data_lake" {
  name                = "pe-${var.project_name}-data-lake-${var.environment_tag}"
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.resource_group.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "psc-${var.project_name}-data-lake-${var.environment_tag}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.data_lake.id
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "pdzg-${var.project_name}-data-lake-${var.environment_tag}"
    private_dns_zone_ids = [azurerm_private_dns_zone.data_lake.id]
  }
}
