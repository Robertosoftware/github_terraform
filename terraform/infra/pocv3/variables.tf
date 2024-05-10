variable "databricks_jobs_permissions" {
  description = "The permissions to assign to the Databricks jobs."
  type = map(object({
    group_name = string
    permission = string
  }))
  default = {
    "hello-world" = {
      group_name = "data_analysts"
      permission = "CAN_VIEW"
    }
  }
} 

variable "environment" {
  description = "The environment to deploy to. Used for naming."
  type        = string
  validation {
    condition     = contains(["devi", "devd", "sbxd", "prdd"], var.environment)
    error_message = "Environment must be one of devi, devd, sbxd, prdd."
  }
}

variable "token" {
  description = "The Databricks token."
  type        = string 
}

variable "account_id" {
  description = "Account id variable."
  type        = string
}