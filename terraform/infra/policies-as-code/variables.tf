variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group to create"
  default = "rg-testinginfra"
}

variable "name_user_assigned_identity" {
  type        = string
  description = "(Required) The name of the User Assigned Managed Identity."
  default = "maniderolerem"
}