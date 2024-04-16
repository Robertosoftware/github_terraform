locals {
  policy_assignments = {
    "Environment-Tag" = {
      tag_name  = "Environment"
      tag_value = "Development"
    },
    "Project-Tag" = {
      tag_name  = var.environment
      tag_value = var.application
    }
  }
}

resource "azurerm_resource_group_policy_assignment" "policy_assignment" {
  for_each            = local.policy_assignments
  name                = each.key
  resource_group_id   = data.azurerm_resource_group.this.id
  policy_definition_id = data.azurerm_policy_definition.applytag.id
  location            = "westeurope"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_assigned_identity.id]
  }
  parameters = jsonencode({
    tagName  = { value = each.value.tag_name }
    tagValue = { value = each.value.tag_value }
  })
}

resource "azurerm_resource_group_policy_remediation" "policy_remediation" {
  for_each               = azurerm_resource_group_policy_assignment.policy_assignment
  name                   = "policy-remediation-${lower(each.key)}"
  resource_group_id      = data.azurerm_resource_group.this.id
  policy_assignment_id   = each.value.id
  resource_discovery_mode = "ReEvaluateCompliance"
}
