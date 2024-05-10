data "databricks_job" "jobs_ids" {
  job_name = var.job_name
  provider = databricks.workspace
}