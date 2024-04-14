data "azurerm_policy_definition" "applytag" {
  name = "5ffd78d9-436d-4b41-a421-5baa819e3008"
}


data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}