variable "group_name" {
  description = "The name of the group. Note that this module assumes the group exists already."
  type        = string
}

variable "job_name" {
  description = "The name of the job. Note that this module assumes the job exists already."
  type        = string
}

variable "permission" {
  description = "The permission to assign the group."
  type        = string
  validation {
    condition     = contains(["CAN_MANAGE", "CAN_USE", "CAN_VIEW"], var.permission)
    error_message = "The permission must be either 'CAN_MANAGE', 'CAN_USE', or 'CAN_VIEW'."
  }
}