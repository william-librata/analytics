# specify databricks providers
terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
    }
  }
}

provider "databricks" {
  host = azurerm_databricks_workspace.databricks.workspace_url
}

# network security group for databricks
resource "azurerm_network_security_group" "databricks" {
  name                = "nsg-${var.department_tag}${var.project_name}databricks${var.environment_tag}-001"
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    environment = var.environment_name
    owner       = var.owner
  }
}

# nsg association
resource "azurerm_subnet_network_security_group_association" "databricks_public" {
  subnet_id                 = azurerm_subnet.databricks_public.id
  network_security_group_id = azurerm_network_security_group.databricks.id
}

resource "azurerm_subnet_network_security_group_association" "databricks_private" {
  subnet_id                 = azurerm_subnet.databricks_private.id
  network_security_group_id = azurerm_network_security_group.databricks.id
}

# databricks workspace
resource "azurerm_databricks_workspace" "databricks" {
  name                          = "dbw-${var.department_tag}-${var.project_name}-${var.environment_tag}"
  resource_group_name           = azurerm_resource_group.resource_group.name
  managed_resource_group_name   = "rg-${var.department_tag}-${var.project_name}-databricks-${var.environment_tag}"
  location                      = var.resource_location
  sku                           = var.databricks_sku
  public_network_access_enabled = var.databricks_public_access

  custom_parameters {
    public_ip_name = "pip-${var.project_name}-databricks-${var.environment_tag}-${var.resource_location}"

    virtual_network_id = azurerm_virtual_network.virtual_network.id

    #public_subnet_name                                   = "snet-${var.project_name}-${var.resource_location}-002"
    public_subnet_name                                  = azurerm_subnet.databricks_public.name
    public_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.databricks_public.id

    #private_subnet_name                                  = "snet-${var.project_name}-${var.resource_location}-003"
    private_subnet_name                                  = azurerm_subnet.databricks_private.name
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.databricks_private.id

    storage_account_name = "st${var.department_tag}${var.project_name}dbw${var.environment_tag}"
  }

  tags = {
    environment = var.environment_name
    owner       = var.owner
  }
}

resource "azurerm_key_vault_access_policy" "databricks" {
  key_vault_id       = var.key_vault_id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  secret_permissions = ["Delete", "Get", "List", "Set"]
}

resource "databricks_secret_scope" "databricks" {
  name = "core-keyvault"

  keyvault_metadata {
    resource_id = var.key_vault_id
    dns_name    = var.key_vault_uri
  }
}