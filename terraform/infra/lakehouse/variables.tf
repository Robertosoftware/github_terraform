variable "location" {
  type        = string
  description = "(Required) The location for the resources in this module"
}

variable "spoke_resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group to create"
}

variable "managed_resource_group_name" {
  type        = string
  description = "(Optional) The name of the resource group where Azure should place the managed Databricks resources"
  default     = ""
}

variable "project_name" {
  type        = string
  description = "(Required) The name of the project associated with the infrastructure to be managed by Terraform"
}

variable "environment_name" {
  type        = string
  description = "(Required) The name of the project environment associated with the infrastructure to be managed by Terraform"
}

variable "spoke_vnet_address_space" {
  type        = string
  description = "(Required) The address space for the spoke Virtual Network"
}

variable "tags" {
  type        = map(string)
  description = "(Required) Map of tags to attach to resources"
  default     = {}
}

variable "databricks_workspace_name" {
  type        = string
  description = "Name of Databricks workspace"
}

variable "data_factory_name" {
  type        = string
  description = "The name of the Azure Data Factory to deploy. Won't be created if not specified"
  default     = ""
}

variable "key_vault_name" {
  type        = string
  description = "(Required) The name of the Azure Data Factory to deploy"
  default     = ""
}

variable "private_subnet_address_prefixes" {
  type        = list(string)
  description = "Address space for private Databricks subnet"
}

variable "public_subnet_address_prefixes" {
  type        = list(string)
  description = "Address space for public Databricks subnet"
}

variable "storage_account_names" {
  type        = string
  description = "Names of the different storage accounts"
}
variable "dbwscope" {
  type        = string
  description = "Names of the databricks scope"
  default     = "dbwscopemount"
}


variable "shared_resource_group_name" {
  type        = string
  description = "Name of the shared resource group"
}

variable "metastore_name" {
  type        = string
  description = "the name of the metastore"
}

variable "metastore_storage_name" {
  type        = string
  description = "the account storage where we create the metastore"
}

variable "access_connector_name" {
  type        = string
  description = "the name of the access connector"
}

variable "secretsname" {
  type = map(any)
  default = {
    "databricksappsecret"   = "databricksappsecret"
    "databricksappclientid" = "databricksappclientid"
    "tenantid"              = "tenantid"
  }
}