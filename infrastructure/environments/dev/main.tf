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
      source  = "hashicorp/azurerm"
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

# local variables
locals{
  project_name = "analytics"
  environment_tag = "dev"
  environment_name = "development"
  resource_location = "australiaeast"   
}

module "resource_group" {
  
  # path
  source = "../../modules/resource_group"

  # info
  project_name = local.project_name
  environment_tag = local.environment_tag
  environment_name = local.environment_name
  resource_location = local.resource_location

}

module "network" {
  
  # path
  source = "../../modules/network"

  # info
  project_name = local.project_name
  environment_tag = local.environment_tag
  environment_name = local.environment_name
  resource_location = local.resource_location
  resource_group_name = module.resource_group.resource_group_name

  # vnet 
  address_spaces = ["10.0.0.0/20"]

  # subnet
  subnets = {

    # catch all subnet
    generic = {
        address_spaces = ["10.0.0.0/24"]
        enforce_private_link_endpoint_network_policies = true
        service_delegation_name = null
    }

    # bastion subnet
    bastion = {
        address_spaces = ["10.0.1.0/26"]
        enforce_private_link_endpoint_network_policies = true
        service_delegation_name = null
    }

    # databricks
    databricks_public = {
        address_spaces = ["10.0.1.64/26"]
        enforce_private_link_endpoint_network_policies = true
        service_delegation_name = "Microsoft.Databricks/workspaces"

    }

    databricks_private = {
        address_spaces = ["10.0.1.128/26"]
        enforce_private_link_endpoint_network_policies = true
        service_delegation_name = "Microsoft.Databricks/workspaces"
    }
  }
}






/*

bastion = ["10.0.1.0/26"]
      databricks_public = ["10.0.1.64/26"]
      databricks_private = ["10.0.1.128/26"]


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
