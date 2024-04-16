# Mounting databricks repo
data "azurerm_key_vault" "this" {
  name                = "kv-engineering1"
  resource_group_name = "airflow"
}

data "azurerm_key_vault_secret" "git_hub" {
  name      = "githubtoken1"
  key_vault_id = data.azurerm_key_vault.this.id
}


resource "databricks_git_credential" "ado" {
  git_username          = "Robertosoftware"
  git_provider          = "gitHub"
  personal_access_token =  data.azurerm_key_vault_secret.git_hub.value
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
  depends_on              = [databricks_git_credential.ado]
  url = "https://github.com/Robertosoftware/scurve-demo-engineering.git"
  path = "/Repos/Engineering/scurve-repo/"
  git_provider = "gitHub"
}

