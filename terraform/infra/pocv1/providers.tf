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


data "azurerm_client_config" "current" {}
