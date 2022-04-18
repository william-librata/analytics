# add storage account private dns
resource "azurerm_private_dns_zone" "private_dns" {
  for_each            = var.private_dns_names
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = merge(var.base_tags, { description = "${each.key} private dns" })
}
