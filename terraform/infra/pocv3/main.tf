module "databricks_jobs_permissions" {
  for_each   = var.databricks_jobs_permissions
  source     = "../modules/databricks_jobs_permissions"
  group_name = each.value["group_name"]
  permission = each.value["permission"]
  job_name   = each.key
  providers = {
    databricks.workspace = databricks.workspace
  }
}
