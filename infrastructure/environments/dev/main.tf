# azure Provider source and version being used
terraform {
  cloud {
    organization = "Librata"

    workspaces {
      name = "azure"
    }
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# get tenant information
data "azurerm_client_config" "current" {
}

# configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

module "resource_group" {
  source = "../../modules/resource_group"

  project_name        = local.project_name
  resource_group_name = local.resource_group_name
  resource_location   = local.resource_location
  base_tags           = local.base_tags
}

module "network" {
  source = "../../modules/network"

  project_name         = local.project_name
  resource_location    = local.resource_location
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network_name
  address_spaces       = local.address_spaces
  subnets              = local.subnets
  base_tags            = local.base_tags
}

module "key_vault" {
  source = "../../modules/key_vault"

  project_name        = local.project_name
  resource_location   = local.resource_location
  resource_group_name = local.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  key_vault_settings  = local.key_vault_settings
  base_tags           = local.base_tags
}

module "private_dns" {

  source = "../../modules/private_dns"

  resource_group_name = local.resource_group_name
  private_dns_names   = local.private_dns_names
  base_tags           = local.base_tags
}

module "data_lake" {

  source = "../../modules/storage"

  project_name             = local.project_name
  resource_group_name      = local.resource_group_name
  resource_location        = local.resource_location
  storage_account_settings = local.data_lake_settings
  base_tags                = local.base_tags

}

module "databricks" {
    source = "../../modules/databricks"

    network_security_group_private_name = local.network_security_group_private_name
    network_security_group_private_subnet_id = lookup(module.network.subnet_ids, "databricks-private")

    network_security_group_public_name = local.network_security_group_public_name
    network_security_group_public_subnet_id = lookup(module.network.subnet_ids, "databricks-public")

    public_ip_name = "pip-${var.project_name}-databricks-${var.environment_tag}-${var.resource_location}"

    storage_account_name = "st${var.department_tag}${var.project_name}dbw${var.environment_tag}"

    key_vault_id = module.key_vault.key_vault_id
    key_vault_uri = module.key_vault.key_vault_uri
    databricks_key_vault_settings = {
        secret_scope_name = "secret-scope"
        secret_permissions = ["Delete", "Get", "List", "Set"]
    }

}




/*




module "data_lake" {

  # path
  source = "../../modules/data_lake"

  project_name        = local.project_name
  resource_location   = local.resource_location
  resource_group_name = local.resource_group_name
  key_vault_name      = local.key_vault_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  key_vault_settings  = local.key_vault_settings
  base_tags           = local.base_tags

}
*/


/*


# get keyvault id from core resource group
data "azurerm_key_vault" "key_vault" {
  name                 = "kv-das-core-dev"
  resource_group_name  = "rg-das-core-dev"
}

# get tenant information
data "azurerm_client_config" "current" {
}

# services module
module "services" {
  
  # path
  source                                                    = "../../modules"

  # core
  project_name                                              = "dwh"
  department_tag                                            = "das"
  department_name                                           = "Data and Analytical Services"
  environment_tag                                           = "dev"
  environment_name                                          = "development"
  cost_centre                                               = "R1858"
  owner                                                     = "reason@alfred.org.au"
  resource_location                                         = "australiasoutheast"

  # security
  key_vault_id                                              = data.azurerm_key_vault.key_vault.id
  key_vault_uri                                             = data.azurerm_key_vault.key_vault.vault_uri

  # database server
  mssql_server_admin_username                               = "dwh_admin"
  mssql_server_admin_username_ad                            = "DB_REASON_ADMIN"
  mssql_server_admin_id_ad                                  = "af533168-3f41-4dfa-8a49-2eb93e67a166"
  mssql_server_version                                      = "12.0"
  mssql_server_public_access                                = true
  mssql_server_minimum_tls_version                          = "1.2"

  # database config
  mssql_sql_database_dap_edition                            = "Standard"
  mssql_sql_database_dap_requested_service_objective_name   = "S0"

  # storage account
  storage_account_tier                                      = "Standard"
  storage_account_replication_type                          = "LRS"
  is_hns_enabled                                            = true

  # databricks
  databricks_sku                                            = "premium"
  databricks_public_access                                  = true

}
*/
