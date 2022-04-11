# core
variable "project_name" {
  description = "The project name to apply to resources"
  type        = string
}

variable "department_tag" {
  description = "Shortened deparment name (data and analytic services - das)"
  type        = string
}

variable "department_name" {
  description = "The full deparment name"
  type        = string
}

variable "environment_tag" {
  description = "The type of environment being deployed to in 3 letter form (e.g. dev, tst, prd)"
  type        = string
}

variable "environment_name" {
  description = "The type of environment being deployed to in long form (e.g. development, test, production)"
  type        = string
}

variable "cost_centre" {
  description = "Cost center"
  type        = string
}

variable "owner" {
  description = "The owner email address of the project"
  type        = string
}

variable "resource_location" {
  description = "The location of the resource"
  type        = string
}


# security
variable "key_vault_id" {
  description = "Key vault ID"
  type        = string
}

variable "key_vault_uri" {
  description = "Key vault URI"
  type        = string
}


# database server
variable "mssql_server_admin_username" {
  description = "The admin username for the Azure SQL DB instance"
  type        = string
}

variable "mssql_server_admin_username_ad" {
  description = "The active directory admin username for the Azure SQL DB instance"
  type        = string
}

variable "mssql_server_admin_id_ad" {
  description = "The active directory admin object id for the Azure SQL DB instance"
  type        = string
}

variable "mssql_server_version" {
  description = "SQL Server version"
  type        = string
}

variable "mssql_server_public_access" {
  description = "Public access flag"
  type        = bool
}

variable "mssql_server_minimum_tls_version" {
  description = "Minimum TLS version"
  type        = string
}


# database config
variable "mssql_sql_database_dap_edition" {
  description = "DAP database edition"
  type        = string
}

variable "mssql_sql_database_dap_requested_service_objective_name" {
  description = "DAP database requested service objective name"
  type        = string
}


# storage account
variable "storage_account_tier" {
  description = "The storage account tier"
  type        = string
}

variable "storage_account_replication_type" {
  description = "Storage account replication type"
  type        = string
}

variable "is_hns_enabled" {
  description = "Is hierarchical namespace enabled?"
  type        = bool
}


# databricks
variable "databricks_sku" {
  description = "Databricks SKU"
  type        = string
}

variable "databricks_public_access" {
  description = "Databricks public access"
  type        = bool
}