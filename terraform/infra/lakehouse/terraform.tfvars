location                    = "West Europe"
spoke_resource_group_name   = "rgdevmlibre1"
managed_resource_group_name = "mrdevmlibre1dbw"
project_name                = "Mlibredemo"
environment_name            = "dev"
spoke_vnet_address_space    = "10.0.0.0/20"
tags = {
  Environment = "Development"
  Project     = "Engineering"
  Testing     = "Mlibredemo"
}
databricks_workspace_name       = "ddevmlibre1dbw"
data_factory_name               = "devmlibre1df"
key_vault_name                  = "devmlibre1kv2"
private_subnet_address_prefixes = ["10.0.1.0/24"]
public_subnet_address_prefixes  = ["10.0.2.0/24"]
storage_account_names           = "devmlibre1saccount"
shared_resource_group_name      = "devmlibre1shared-resources"
metastore_name                  = "devmlibre1ms"
metastore_storage_name          = "devmlibre1maccount"
access_connector_name           = "devmlibre1macon"
