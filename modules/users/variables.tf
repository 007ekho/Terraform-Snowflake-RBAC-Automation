variable "users" {
  description = "Map of users to create"
  type = map(object({
    login_name           = string
    display_name         = string
    email                = string
    default_role         = string
    must_change_password = bool
  }))
}