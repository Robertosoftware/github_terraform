locals {
  role_assignments = {
    "Tag Contributor"            = "Tag Contributor",
    "Resource Policy Contributor" = "Resource Policy Contributor"
  }
}

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = var.name_user_assigned_identity
  location            = "West Europe"
  resource_group_name = data.azurerm_resource_group.this.name
  tags                = var.managed_identity_tags
}


resource "azurerm_role_assignment" "role_policy" {
  for_each            = local.role_assignments
  scope               = data.azurerm_resource_group.this.id
  role_definition_name = each.value
  principal_id        = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}