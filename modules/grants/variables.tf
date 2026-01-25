variable "role_grants" {
  description = "Role grants to users"
  type = map(object({
    roles = list(string)
    users = list(string)
  }))
}