# Mounting databricks repo
resource "databricks_git_credential" "ado" {
  git_username          = "robertosoftware"
  git_provider          = "gitHub"
  personal_access_token =  var.github_token
}

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


resource "databricks_repo" "dbrepo03" {
  depends_on              = [databricks_git_credential.adp]
  url = "https://github.com/Robertosoftware/scurve-demo-engineering.git"
  path = "/Repos/Engineering/scurve-repo/"
  git_provider = "gitHub"
}

