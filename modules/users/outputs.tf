output "user_names" {
  description = "Map of user names"
  value       = { for k, v in snowflake_user.users : k => v.name }
}
