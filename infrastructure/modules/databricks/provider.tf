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