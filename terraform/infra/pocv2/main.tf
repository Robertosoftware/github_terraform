terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "1.42.0"
    }
  }
}

variable "token" {
  description = "The Databricks token."
  type        = string 
}

variable "environment" {
  type = string
}

variable "group_name" {
  description = "The name of the group. Note that this module assumes the group exists already."
  type        = string
}

variable "account_id" {
  description = "Account id variable."
  type        = string
}

provider "databricks" {
    host  = "https://adb-1689648540814705.5.azuredatabricks.net/"
    token = var.token
}

provider "databricks" {
  alias      = "account"
  host       = "accounts.azuredatabricks.net"
  account_id = var.account_id
}

provider "databricks" {
  alias = "workspace"
  host  =  "https://adb-1689648540814705.5.azuredatabricks.net/"
}

data "databricks_jobs" "this" {}

data "databricks_group" "data_analysts" {
  display_name = var.group_name
}

# Use the workspace provider
resource "databricks_permission_assignment" "this" {
  principal_id = data.databricks_group.data_analysts.id
  permissions  = ["USER"]
  provider     = databricks.workspace
}
resource "databricks_entitlements" "workspace-users" {
  group_id                   = data.databricks_group.data_analysts.id
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = false
  workspace_access           = true
}

/*
resource "databricks_permissions" "data_analysts_view_all_jobs" {
  for_each = (var.environment == "devi" || var.environment == "devd" || var.environment == "prdd") && var.group_name == "data_analysts" ? { for idx, job_id in data.databricks_jobs.this.ids : idx => job_id } : {}

  job_id   = each.value

  access_control {
    group_name       = var.group_name
    permission_level = "CAN_VIEW"
  }
}*/