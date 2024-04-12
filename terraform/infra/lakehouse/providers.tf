terraform {
  cloud {
    organization = "inteliia"
    workspaces {
      name = "engineering-workspace"
    }
  }
}

provider "azurerm" {
  features {}
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