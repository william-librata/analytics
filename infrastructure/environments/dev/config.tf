locals {
    # info
    project_name = "analytics"
    environment_tag   = "dev"
    environment_name  = "development"
    resource_location = "australiaeast"
    domain_name       = "walys"

    # tags
    base_tags = {
        environment = local.environment_name
        project     = local.project_name
    }

    # resource group
    resource_group_name = "rg-${local.project_name}-${local.environment_tag}"

    # networking
    virtual_network_name = "vnet-${local.project_name}-${local.environment_tag}"
    address_spaces       = ["10.0.0.0/20"]
    subnets = {

        # catch all subnet
        generic = {
            address_spaces                                 = ["10.0.0.0/24"]
            enforce_private_link_endpoint_network_policies = true
            service_delegation_name                        = null
        }

        # bastion subnet
        bastion = {
            address_spaces                                 = ["10.0.1.0/26"]
            enforce_private_link_endpoint_network_policies = true
            service_delegation_name                        = null
        }

        # databricks public
        databricks-public = {
            address_spaces                                 = ["10.0.1.64/26"]
            enforce_private_link_endpoint_network_policies = true
            service_delegation_name                        = "Microsoft.Databricks/workspaces"

        }

        # databricks private
        databricks-private = {
            address_spaces                                 = ["10.0.1.128/26"]
            enforce_private_link_endpoint_network_policies = true
            service_delegation_name                        = "Microsoft.Databricks/workspaces"
        }
    }

    # key vault
    key_vault_name = "kv-${local.domain_name}-${local.project_name}-${local.environment_tag}"
    key_vault_settings = {
        soft_delete_retention_days = 30
        purge_protection_enabled   = false
        sku_name                   = "standard"
    }

    # private dns
    private_dns_names = {
        blob = "privatelink.blob.core.windows.net"
    }
}