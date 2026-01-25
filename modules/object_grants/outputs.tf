output "database_grants" {
  description = "Created database grants"
  value       = { for k, v in snowflake_grant_privileges_to_account_role.database_grants : k => v.id }
}

output "schema_grants" {
  description = "Created schema grants"
  value       = { for k, v in snowflake_grant_privileges_to_account_role.schema_grants : k => v.id }
}

output "warehouse_grants" {
  description = "Created warehouse grants"
  value       = { for k, v in snowflake_grant_privileges_to_account_role.warehouse_grants : k => v.id }
}