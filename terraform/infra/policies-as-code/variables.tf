locals {
  rg_name = "airflow"
  maid_name = "airflow_mani"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group to create"
  default = "airflow"
}

variable "name_user_assigned_identity" {
  type        = string
  description = "(Required) The name of the User Assigned Managed Identity."
  default =  "airflow_mani"
}

variable "application" {
  type        = string
  description = "(Required) The name of the application."
  default = "Engineering"
}

variable "managed_identity_tags" {
  type    = map(string)
  default = {
    Environment = "Development"
    Project  = "Engineering"
  }
}