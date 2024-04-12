terraform {
  cloud {
    organization = "inteliia"
    workspaces {
      name = "engineering-workspace"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
    }
  }
}

provider "azuread" {
  # Configuration options
}

provider "time" {
  # Configuration options
}

# Very important provider for databricks authentication in Azure
provider "databricks" {
  host                        = module.adb-lakehouse.workspace_url
  azure_workspace_resource_id = module.adb-lakehouse.workspace_resource_id
}