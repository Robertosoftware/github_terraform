# Declaring locals
locals {
  containers = {
    source = "ctdatasource",
    bronze = "ctdatabronze",
    silver = "ctdatasilver",
    gold   = "ctdatagold"
    quarantine   = "ctdataquarantine"
  }
}
# Creating storage account
resource "azurerm_storage_account" "dls" {
  depends_on   = [azurerm_resource_group.this]
  name                     = "dls${var.storage_account_names}${var.environment_name}"
  location                 = var.location
  resource_group_name      = var.spoke_resource_group_name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = var.tags
  is_hns_enabled           = true
  min_tls_version          = "TLS1_2"

}


# Create containers for raw quarantine, bronze, silver and gold layer
resource "azurerm_storage_container" "ctdataquarantine" {
  name                  = local.containers.quarantine
  storage_account_name  = azurerm_storage_account.dls.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "ctdatasource" {
  name                  = local.containers.source
  storage_account_name  = azurerm_storage_account.dls.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "ctdatabronze" {
  name                  = local.containers.bronze
  storage_account_name  = azurerm_storage_account.dls.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "ctdatasilver" {
  name                  = local.containers.silver
  storage_account_name  = azurerm_storage_account.dls.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "ctdatagold" {
  name                  = local.containers.gold
  storage_account_name  = azurerm_storage_account.dls.name
  container_access_type = "private"
}

# Uploading data to data source container
resource "azurerm_storage_blob" "ctdatasourceblob" {
  for_each               = fileset(path.module, "raw_data/*")
  name                   = "${trimsuffix(trimprefix(each.key, "raw_data/"), ".csv")}/${trimprefix(each.key, "raw_data/")}"
  storage_account_name   = azurerm_storage_account.dls.name
  storage_container_name = azurerm_storage_container.ctdatasource.name
  type                   = "Block"
  source                 = each.key
}

