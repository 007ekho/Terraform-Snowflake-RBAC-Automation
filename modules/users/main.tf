terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.100"
    }
  }
}

resource "snowflake_user" "users" {
  for_each = var.users
  
  name                 = upper(each.value.login_name)
  login_name           = each.value.login_name
  display_name         = each.value.display_name
  email                = each.value.email
  default_role         = upper(each.value.default_role)
  must_change_password = each.value.must_change_password
}