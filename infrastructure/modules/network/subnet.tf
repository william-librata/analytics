resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name = "snet-${var.project_name}-${each.key}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = each.value.address_spaces
  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies

  dynamic "delegation" {
        for_each = each.value.service_delegation == true ? [1] : []
        
        content {
            name = "databricks delegation"

            service_delegation {
                actions = [
                    "Microsoft.Network/virtualNetworks/subnets/join/action",
                    "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
                    "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
                    ]
                name = "Microsoft.Databricks/workspaces"
            }        
        }
    }
}

/*
resource "azurerm_subnet" "azr_subnet" {
    for_each = var.subnets

    name = each.key
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = each.value.cidr
    enforce_private_link_endpoint_network_policies = true
    
    dynamic "delegation" {
        for_each = each.value.service_delegation == "true" ? [1] : []
        
        content {
            name = "delegation"

            service_delegation {
            name    = "Microsoft.ContainerInstance/containerGroups"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
            }        
        }
    
    }
}
*/