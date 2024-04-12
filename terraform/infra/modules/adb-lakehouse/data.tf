# Basic Azure Resource Manager data
data "azuread_client_config" "current" {}

data "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 0 : 1
  name  = var.spoke_resource_group_name
}

locals {
  rg_name     = var.create_resource_group ? azurerm_resource_group.this[0].name : data.azurerm_resource_group.this[0].name
  rg_id       = var.create_resource_group ? azurerm_resource_group.this[0].id : data.azurerm_resource_group.this[0].id
  rg_location = var.create_resource_group ? azurerm_resource_group.this[0].location : data.azurerm_resource_group.this[0].location
}

data "azurerm_client_config" "current" {
}


# Necessary provider for databricks service principal interaction
data "azuread_service_principal" "azuredatabricks" {
  display_name = "AzureDatabricks"
}

# Data for Databricks cluster creation
data "databricks_node_type" "smallest" {
  depends_on = [azurerm_databricks_workspace.this]
  local_disk = true
  category   = "General Purpose"
}

data "databricks_spark_version" "latest" {
  depends_on        = [azurerm_databricks_workspace.this]
  long_term_support = true
  latest            = true
}