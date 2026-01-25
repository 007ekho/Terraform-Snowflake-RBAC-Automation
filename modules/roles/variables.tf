variable "roles" {
  description = "Map of roles to create"
  type = map(object({
    comment = string
  }))
}