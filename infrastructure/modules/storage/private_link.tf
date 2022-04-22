/*# add link to virtual network
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
*/