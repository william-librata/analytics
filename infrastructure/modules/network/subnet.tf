resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name = "snet-${var.project_name}-${replace(each.key, "_", "-")}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = each.value.address_spaces
  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies

  dynamic "delegation" {
        for_each = each.value.service_delegation_name == true ? [1] : []
        
        content {
            name = "subnet delegation"
            service_delegation {
                name = each.value.service_delegation_name
            }        
        }
    }
}
