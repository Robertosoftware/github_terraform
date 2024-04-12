# Mounting databricks repo
resource "databricks_repo" "dbrepo01" {
  url = "https://github.com/Robertosoftware/Databricks-First-Class-MLOps.git"
}
