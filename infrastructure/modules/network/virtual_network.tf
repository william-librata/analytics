resource "azurerm_virtual_network" "virtual_network" {
  name = "vnet-${var.project_name}-${var.environment_tag}"
  location = var.resource_location
  resource_group_name = var.resource_group_name
  address_space = var.address_spaces
  
  tags = {
      environment = var.environment_name
      project = var.project_name
      description = "${var.project_name} virtual network"
  }
}

/*
resource "azurerm_subnet" "generic" {
  name                                           = "snet-${var.project_name}-generic"
  resource_group_name                            = azurerm_resource_group.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = ["10.0.0.0/24"]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "bastion" {
  name                                           = "snet-${var.project_name}-bastion"
  resource_group_name                            = azurerm_resource_group.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = ["10.0.1.0/26"]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "databricks_public" {
  name                                           = "snet-${var.project_name}-databricks-public"
  resource_group_name                            = azurerm_resource_group.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = ["10.0.1.64/26"]

  delegation  {
    name               = "databricks_delegation"
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

resource "azurerm_subnet" "databricks_private" {
  name                                           = "snet-${var.project_name}-databricks-public"
  resource_group_name                            = azurerm_resource_group.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = ["10.0.1.128/26"]
  
  delegation  {
    name               = "databricks_delegation"
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
*/