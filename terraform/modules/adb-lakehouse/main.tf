# Resource Group creation
resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.spoke_resource_group_name
  location = var.location
  tags     = var.tags
}