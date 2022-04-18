# add storage account private dns
resource "azurerm_private_dns_zone" "data_lake" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.resource_group.name
}
