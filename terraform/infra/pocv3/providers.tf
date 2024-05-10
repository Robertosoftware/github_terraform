provider "databricks" {
    host  = "https://adb-1689648540814705.5.azuredatabricks.net/"
    token = var.token
}

provider "databricks" {
  alias      = "account"
  host       = "accounts.azuredatabricks.net"
  account_id = var.account_id
}

provider "databricks" {
  alias = "workspace"
  host  =  "https://adb-1689648540814705.5.azuredatabricks.net/"
}


