resource "databricks_permissions" "jobs_permissions" {
  job_id = data.databricks_job.jobs_ids.id

  access_control {
    group_name       = var.group_name
    permission_level = var.permission
  }
  provider = databricks.workspace
}
