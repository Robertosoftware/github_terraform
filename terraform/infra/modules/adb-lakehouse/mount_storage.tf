# Create Databricks Scope
resource "databricks_secret_scope" "dbwscope" {
  depends_on               = [azurerm_databricks_workspace.this, azurerm_key_vault.kvdatabricks]
  name                     = var.dbwscope
  initial_manage_principal = "users"

  keyvault_metadata {
    resource_id = azurerm_key_vault.kvdatabricks.id
    dns_name    = azurerm_key_vault.kvdatabricks.vault_uri
  }`
}

# Create Single Node Cluster
resource "databricks_cluster" "dbcluster01" {
  depends_on              = [azurerm_databricks_workspace.this]
  cluster_name            = "dbcluster${var.environment_name}01"
  num_workers             = 0
  spark_version           = data.databricks_spark_version.latest.id # Other possible values ("13.3.x-scala2.12", "11.2.x-cpu-ml-scala2.12", "7.0.x-scala2.12")
  node_type_id            = data.databricks_node_type.smallest.id # Other possible values ("Standard_F4", "Standard_DS3_v2")
  autotermination_minutes = 20

  spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }

}

# Mount storage
resource "databricks_mount" "dbmount" {
  for_each = local.containers

  name       = "tf-abfss${var.environment_name}-${each.key}01"
  cluster_id = databricks_cluster.dbcluster01.cluster_id
  uri        = "abfss://${each.value}@${azurerm_storage_account.dls.name}.dfs.core.windows.net"
  extra_configs = {
    "fs.azure.account.auth.type"                          = "OAuth"
    "fs.azure.account.oauth.provider.type"                = "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
    "fs.azure.account.oauth2.client.id"                   = azuread_application.databricksapp.application_id
    "fs.azure.account.oauth2.client.secret"               = azuread_application_password.databricksapp.value
    "fs.azure.account.oauth2.client.endpoint"             = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/oauth2/token"
    "fs.azure.createRemoteFileSystemDuringInitialization" = "false"
  }
}