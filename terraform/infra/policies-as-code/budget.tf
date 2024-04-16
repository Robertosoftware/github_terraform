resource "azurerm_consumption_budget_subscription" "main" {
  name            = "Budget-${var.application}"
  subscription_id = data.azurerm_subscription.current.id
  amount     = 100
  time_grain = "Monthly"

  time_period {
    start_date = "2024-04-01T00:00:00Z"
  }

  notification {
    enabled   = true
    threshold = 70.0
    threshold_type = "Actual"
    operator  = "GreaterThanOrEqualTo"

    contact_emails = [
      "bonilla.ibarra.roberto@hotmail.com",
      "robertodgb@gmail.com",
    ]
  }

  notification {
    enabled        = true
    threshold      = 90.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = [
      "bonilla.ibarra.roberto@hotmail.com",
      "robertodgb@gmail.com",
    ]
  }
}