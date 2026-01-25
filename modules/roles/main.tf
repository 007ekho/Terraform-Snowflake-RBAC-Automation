terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.100"
    }
  }
}

resource "snowflake_account_role" "roles" {
  for_each = var.roles
  
  name    = upper(each.key)
  comment = each.value.comment
}
