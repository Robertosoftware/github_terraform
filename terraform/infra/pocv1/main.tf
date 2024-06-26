resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}app-rg"
  location = var.location
}

resource "azurerm_storage_account" "main" {
  name                     = "${var.app_name}appsa"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version = "TLS1_2"

}

resource "azurerm_storage_container" "main" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_resource_group" "demo" {
  name     = "example-resources"
  location = "West Europe"
}

##  Demo now
resource "azurerm_storage_account" "StorageAccountDemo" {
  name                     = "satestant000012"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version = "TLS1_2"


  tags = {
    video = "azure"
    channel = "CloudQuickLabs"
  }
}