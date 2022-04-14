# randomly generate passwords 
resource "random_password" "mssql_server_admin_password" {
  length           = 20
  special          = true
  override_special = "_%@"
}

# sql server 
resource "azurerm_mssql_server" "sql_server" {
  name                          = "sqldb-${var.department_tag}-${var.project_name}-${var.environment_tag}"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = var.resource_location
  version                       = var.mssql_server_version
  administrator_login           = var.mssql_server_admin_username
  administrator_login_password  = random_password.mssql_server_admin_password.result
  public_network_access_enabled = var.mssql_server_public_access
  minimum_tls_version           = var.mssql_server_minimum_tls_version

  azuread_administrator {
    login_username = var.mssql_server_admin_username_ad
    object_id      = var.mssql_server_admin_id_ad
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment_name
    Department  = var.department_name
    CostCentre  = var.cost_centre
    Project     = var.project_name
    Description = "${var.project_name} database server"
    Owner       = var.owner
  }
}

# firewall - alfred vpn ip
resource "azurerm_mssql_firewall_rule" "vpn" {
  name             = "vpn_ip"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "203.0.239.3"
  end_ip_address   = "203.0.239.3"
}

# setup database
resource "azurerm_sql_database" "metadata" {
  name                             = "metadata"
  resource_group_name              = azurerm_resource_group.resource_group.name
  location                         = var.resource_location
  server_name                      = azurerm_mssql_server.sql_server.name
  edition                          = var.mssql_sql_database_dap_edition
  requested_service_objective_name = var.mssql_sql_database_dap_requested_service_objective_name

  lifecycle {
    ignore_changes = [
      requested_service_objective_name
    ]
  }

  tags = {
    Environment = var.environment_name
    Department  = var.department_name
    CostCentre  = var.cost_centre
    Project     = var.project_name
    Description = "Metadata database"
    Owner       = var.owner
  }
}

# put into key vault
resource "azurerm_key_vault_secret" "sql_server_username" {
  name         = "sqldb-${var.department_tag}-${var.project_name}-${var.environment_tag}-username"
  value        = var.mssql_server_admin_username
  key_vault_id = var.key_vault_id

  tags = {
    Environment = var.environment_name
    Department  = var.department_name
    CostCentre  = var.cost_centre
    Project     = var.project_name
    Description = "DWH metadata database username"
    Owner       = var.owner
  }
}

resource "azurerm_key_vault_secret" "sql_server_password" {
  name         = "sqldb-${var.department_tag}-${var.project_name}-${var.environment_tag}-password"
  value        = random_password.mssql_server_admin_password.result
  key_vault_id = var.key_vault_id

  tags = {
    Environment = var.environment_name
    Department  = var.department_name
    CostCentre  = var.cost_centre
    Project     = var.project_name
    Description = "DWH metadata database password"
    Owner       = var.owner
  }
}

resource "azurerm_key_vault_secret" "sql_server_connection_string" {
  name         = "sqldb-${var.department_tag}-${var.project_name}-${var.environment_tag}-metadata-connection-string"
  value        = "Server=${azurerm_mssql_server.sql_server.fully_qualified_domain_name};User ID=${var.mssql_server_admin_username};Password=${random_password.mssql_server_admin_password.result};Initial Catalog=${azurerm_sql_database.metadata.name}"
  key_vault_id = var.key_vault_id

  tags = {
    Environment = var.environment_name
    Department  = var.department_name
    CostCentre  = var.cost_centre
    Project     = var.project_name
    Description = "DWH metadata database connection string"
    Owner       = var.owner
  }
}