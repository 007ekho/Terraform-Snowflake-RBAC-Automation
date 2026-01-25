terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.100"
    }
  }
}



locals {
  # Flatten the structure to create individual grants
  role_user_pairs = flatten([
    for grant_key, grant in var.role_grants : [
      for role in grant.roles : [
        for user in grant.users : {
          key  = "${grant_key}_${role}_${user}"
          role = role
          user = user
        }
      ]
    ]
  ])
}


resource "snowflake_grant_account_role" "role_to_user" {
  for_each = { for pair in local.role_user_pairs : pair.key => pair }
  
  role_name = upper(each.value.role)
  user_name = upper(each.value.user)
}