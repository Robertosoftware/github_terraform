
# Create Key vault
resource "azurerm_key_vault" "kvdatabricks" {
  name                        = var.key_vault_name
  location                    = local.rg_location
  resource_group_name         = local.rg_name
  enable_rbac_authorization   = false
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  # Access policy principal account
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions     = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
    secret_permissions  = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
    storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]

  }

  # Access policy for AzureDatabricks Account
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_service_principal.azuredatabricks.object_id

    secret_permissions = ["Get", "List"]
  }

  sku_name = "standard"
}


# Create Application
resource "azuread_application" "databricksapp" {
  display_name     = "svcprdatabricks${var.project_name}${var.environment_name}"
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
}



# Create Service Principal
resource "azuread_service_principal" "databricksapp" {
  application_id               = azuread_application.databricksapp.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
    gallery    = true
  }
}

# Assgn key rotation
resource "time_rotating" "two_years" {
  rotation_days = 720
}

# Assign role to service principal
resource "azurerm_role_assignment" "databricksapp" {
  scope                = azurerm_storage_account.dls.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.databricksapp.id
}

# Create secret for App
resource "azuread_application_password" "databricksapp" {
  depends_on            = [azurerm_key_vault.kvdatabricks]
  display_name          = "databricksapp App Password"
  application_object_id = azuread_application.databricksapp.object_id

  rotate_when_changed = {
    rotation = time_rotating.two_years.id
  }
}


# Store secret, clientid and tenantid in secret
resource "azurerm_key_vault_secret" "databricksappsecret" {
  name         = var.secretsname["databricksappsecret"]
  value        = azuread_application_password.databricksapp.value
  key_vault_id = azurerm_key_vault.kvdatabricks.id
}

resource "azurerm_key_vault_secret" "databricksappclientid" {
  name         = var.secretsname["databricksappclientid"]
  value        = azuread_application.databricksapp.application_id
  key_vault_id = azurerm_key_vault.kvdatabricks.id
}

resource "azurerm_key_vault_secret" "tenantid" {
  name         = var.secretsname["tenantid"]
  value        = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.kvdatabricks.id
}


