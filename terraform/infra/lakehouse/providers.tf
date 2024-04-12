provider "azurerm" {
  features {}
}


terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  cloud {
    organization = "inteliia"
    workspaces {
      name = "engineering-workspace"
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
  host                        = module.adb-lakehouse.workspace_id
  azure_workspace_resource_id = module.adb-lakehouse.id
}