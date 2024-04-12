# Mounting databricks repo
resource "databricks_repo" "dbrepo01" {
  url = "https://github.com/Robertosoftware/databricks-demo-engineering.git"
  path = "/Repos/Engineering/code-repo/"
  git_provider = "gitHub"
}

resource "databricks_repo" "dbrepo02" {
  url = "https://github.com/Robertosoftware/Databricks-First-Class-MLOps.git"
  path = "/Repos/AI/mlops/"
  git_provider = "gitHub"
}