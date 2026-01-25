output "role_names" {
  description = "Map of role names"
  value       = { for k, v in snowflake_account_role.roles : k => v.name }
}